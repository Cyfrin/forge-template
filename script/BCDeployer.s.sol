// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { BCScript } from "battlechain-lib/BCScript.sol";
import { Contact } from "battlechain-lib/types/AgreementTypes.sol";
import { Counter } from "src/Counter.sol";

/// @notice Unified deployment for BattleChain and any CreateX-supported EVM chain.
///
/// BattleChain (deploys via BattleChainDeployer, adopts agreement, enters attack mode):
///   forge script script/BCDeployer.s.sol \
///       --rpc-url $BC_TESTNET_RPC --account $ACCOUNT --sender $SENDER \
///       --broadcast --skip-simulation -g 300 --legacy
///
/// Any other supported chain (deploys via CreateX, creates Safe Harbor agreement):
///   forge script script/BCDeployer.s.sol \
///       --rpc-url $RPC --account $ACCOUNT --sender $SENDER --broadcast
///
/// @custom:security-contact security@example.com
contract BCDeployer is BCScript {
    function _protocolName() internal pure override returns (string memory) {
        return "ExampleProtocol";
    }

    function _contacts() internal pure override returns (Contact[] memory) {
        Contact[] memory c = new Contact[](1);
        c[0] = Contact({ name: "Security Team", contact: "security@example.com" });
        return c;
    }

    /// @notice Address that receives recovered assets after a successful attack.
    /// @dev Replace with a multisig before mainnet deployment.
    function _recoveryAddress() internal view override returns (address) {
        return msg.sender;
    }

    function run() external {
        vm.startBroadcast();

        bcDeployCreate(type(Counter).creationCode);

        address agreement = createAndAdoptAgreement(
            defaultAgreementDetails(
                _protocolName(), _contacts(), getDeployedContracts(), _recoveryAddress()
            ),
            msg.sender,
            keccak256("v1")
        );

        if (_isBattleChain()) {
            requestAttackMode(agreement);
        }

        vm.stopBroadcast();
    }
}
