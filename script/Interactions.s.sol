//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundMeFunding(address recentlyDeployed) public {
        FundMe(payable(recentlyDeployed)).fund{value: SEND_VALUE}();
        // console.log("Funded fundme with $ ", SEND_VALUE);
    }

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundMeFunding(mostRecentDeployed);
        vm.stopBroadcast();
    }
}

contract WithDrawFundMe is Script {
    function fundMeWithDraw(address recentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(recentlyDeployed)).withdraw();
        vm.stopBroadcast();

        // console.log("Funded fundme with $ ", SEND_VALUE);
    }

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        // vm.startBroadcast();
        fundMeWithDraw(mostRecentDeployed);
        // vm.stopBroadcast();
    }
}
