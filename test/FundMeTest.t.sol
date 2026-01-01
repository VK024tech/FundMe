//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumDollarIsFive() public {
        console.log("Minimum USD:", fundMe.MINIMUM_USD());
        uint256 expected = 5 * 10 ** 18;
        assertEq(fundMe.MINIMUM_USD(), expected);
    }

    function testOwnerIsMsgSender() public {
        console.log("Owner:", fundMe.I_OWNER());
        console.log("Msg Sender:", msg.sender);
        assertEq(fundMe.I_OWNER(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}
