// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";

contract DeployOurToken is Script {
    constructor() {}

    function run(uint totalBalance) external returns (OurToken) {
        vm.startBroadcast();
        OurToken ourToken = new OurToken(totalBalance);
        vm.stopBroadcast();
        return ourToken;
    }
}
