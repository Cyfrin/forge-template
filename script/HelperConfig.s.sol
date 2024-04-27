// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { Script } from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";

contract HelperConfig is Script {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error HelperConfig__InvalidChainId();

    /*//////////////////////////////////////////////////////////////
                                 TYPES
    //////////////////////////////////////////////////////////////*/
    struct NetworkConfig {
        address someVar;
    }

    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    uint256 constant ETH_MAINNET_CHAIN_ID = 1;
    uint256 constant ETH_SEPOLIA_CHAIN_ID = 11_155_111;

    uint256 constant ZKSYNC_MAINNET_CHAIN_ID = 324;
    uint256 constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;

    uint256 constant POLYGON_MAINNET_CHAIN_ID = 137;
    uint256 constant POLYGON_MUMBAI_CHAIN_ID = 80_001;

    // Local network state variables
    NetworkConfig public localNetworkConfig;
    mapping(uint256 chainId => NetworkConfig) public networkConfigs;

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    constructor() {
        networkConfigs[ETH_MAINNET_CHAIN_ID] = getEthMainnetConfig();
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getZkSyncSepoliaConfig();
        networkConfigs[ZKSYNC_MAINNET_CHAIN_ID] = getZkSyncConfig();
        networkConfigs[ZKSYNC_SEPOLIA_CHAIN_ID] = getZkSyncSepoliaConfig();
        networkConfigs[POLYGON_MAINNET_CHAIN_ID] = getPolygonMainnetConfig();
        networkConfigs[POLYGON_MUMBAI_CHAIN_ID] = getPolygonMumbaiConfig();
    }

    function getConfigByChainId(uint256 chainId) public returns (NetworkConfig memory) {
        if (networkConfigs[chainId].someVar != address(0)) {
            return networkConfigs[chainId];
        } else {
            return getOrCreateAnvilEthConfig();
        }
    }

    function getActiveNetworkConfig() public returns (NetworkConfig memory) {
        return getConfigByChainId(block.chainid);
    }

    /*//////////////////////////////////////////////////////////////
                                CONFIGS
    //////////////////////////////////////////////////////////////*/
    function getEthMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ someVar: address(1) });
    }

    function getZkSyncConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ someVar: address(1) });
    }

    function getZkSyncSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ someVar: address(1) });
    }

    function getPolygonMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ someVar: address(1) });
    }

    function getPolygonMumbaiConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ someVar: address(1) });
    }

    /*//////////////////////////////////////////////////////////////
                              LOCAL CONFIG
    //////////////////////////////////////////////////////////////*/
    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (localNetworkConfig.someVar != address(0)) {
            return localNetworkConfig;
        }
        console2.log(unicode"⚠️ You have deployed a mock conract!");
        console2.log("Make sure this was intentional");

        _deployMocks();
        
        localNetworkConfig = NetworkConfig({ someVar: address(1) });
        return localNetworkConfig;
    }

    /*
     * Add your mocks, deploy and return them here for your local anvil network
     */
    function _deployMocks() internal { }
}
