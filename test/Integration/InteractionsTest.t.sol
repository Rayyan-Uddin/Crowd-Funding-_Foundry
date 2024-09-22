// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.18;

// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../../src/FundMe.sol";
// import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
// import {FundFundMe, WithDrawFundMe} from "../../script/Interactions.s.sol";

// contract InteractionTest is Test {
//     FundMe fundMe;
//     address USER = makeAddr("user");
//     uint256 constant SEND_VALUE = 0.1 ether;
//     uint256 USER_BAL = 10 ether;

//     function setUp() external {
//         DeployFundMe deploy = new DeployFundMe();
//         fundMe = deploy.run();
//         vm.deal(USER, USER_BAL);
//     }

//     function testUserCanFundInteractions() public {
//         FundFundMe fundFundMe = new FundFundMe();
//         // vm.prank(USER);
//         // vm.deal(USER, 1e18);
//         fundFundMe.fundMeFunding(address(fundMe));
//         // address funder = fundMe.getFunder(0);
//         // assertEq(funder, USER);
//         WithDrawFundMe withdrawFundMe = new WithDrawFundMe();
//         withdrawFundMe.fundMeWithDraw(address(fundMe));

//         //assert(address(fundMe).balance == 0);
//     }
// }
