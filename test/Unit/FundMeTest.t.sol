//SPDX-License-Identifier : MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 USER_BAL = 10 ether;

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, USER_BAL);
    }

    function testMinUSDisFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerisMsgSender() public view {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testGetVersionisAccurate() public view {
        uint256 versionView = fundMe.getVersion();
        assertEq(versionView, 4);
    }

    function testMinEthValue() public {
        vm.expectRevert();
        fundMe.fund();
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testAmountFunded() public funded {
        uint256 getAmount = fundMe.getAddressToAmountFunded(USER);
        console.log(getAmount);
        console.log(SEND_VALUE);
        assertEq(getAmount, SEND_VALUE);
    }

    function testArrayofFunders() public funded {
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    function testOnlyOwnerCanWithDraw() public funded {
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithDrawWithSingleFunder() public funded {
        //arrange
        uint256 startOwnerBalance = fundMe.getOwner().balance;
        uint256 startFundMeBalance = address(fundMe).balance;

        //act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        //assert
        uint256 endOwnerBalance = fundMe.getOwner().balance;
        uint256 endFundMeBalance = address(fundMe).balance;
        console.log(startFundMeBalance, startOwnerBalance);
        assertEq(endFundMeBalance, 0);
        assertEq(startOwnerBalance + startFundMeBalance, endOwnerBalance);
    }

    function testWithDrawWithMultipleFunders() public {
        uint160 totalFunder = 10;
        for (uint160 i = 1; i < totalFunder; i++) {
            //hoax creats new address with some value
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }
        uint256 ownerBalance = fundMe.getOwner().balance;
        uint256 fundMeBalance = address(fundMe).balance;

        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        assert(address(fundMe).balance == 0);
        assert(ownerBalance + fundMeBalance == fundMe.getOwner().balance);
    }
}
