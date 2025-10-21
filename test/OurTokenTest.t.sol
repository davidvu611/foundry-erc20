//SPDX-License-Identier: MIT
pragma solidity 0.8.24;
import {Test} from "forge-std/Test.sol";
import {console2} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OutTokenTest is Test {
    uint constant TOKEN_BALANCE = 99999 ether;
    uint constant USER_START_BALANCE = 100 ether;
    DeployOurToken deployer;
    OurToken ourToken;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address charlie = makeAddr("charlie");

    modifier supplyToBob() {
        vm.prank(msg.sender);
        ourToken.transfer(bob, USER_START_BALANCE);
        _;
    }

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run(TOKEN_BALANCE);
    }

    // ---  Basic ---
    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), TOKEN_BALANCE);
    }

    function testBobBalance() public supplyToBob {
        assertEq(ourToken.balanceOf(bob), USER_START_BALANCE);
    }

    // ---  Transfers ---
    function testTransferDecreasesSenderBalance() public {
        uint amount = 9 ether;
        // Supply Alice some money
        vm.prank(msg.sender);
        ourToken.transfer(alice, USER_START_BALANCE);

        vm.prank(alice);
        ourToken.transfer(charlie, amount);

        assertEq(ourToken.balanceOf(alice), USER_START_BALANCE - amount);
        assertEq(ourToken.balanceOf(charlie), amount);
    }

    function testTransferFailsIfInsufficientBalance() public {
        uint256 amount = 10 ether;

        vm.expectRevert();
        vm.prank(bob); // bob has 0 initially
        ourToken.transfer(alice, amount);
    }

    function testTransferFromUsesAllowance() public {
        uint256 allowanceAmount = 50 ether;
        uint256 transferAmount = 20 ether;

        // Supply Alice some money
        vm.prank(msg.sender);
        ourToken.transfer(alice, USER_START_BALANCE);

        // Alice approves Bob
        vm.prank(alice);
        ourToken.approve(bob, allowanceAmount);

        // Bob transfers from Alice to Charlie
        vm.prank(bob);
        ourToken.transferFrom(alice, charlie, transferAmount);

        assertEq(ourToken.balanceOf(charlie), transferAmount);
        assertEq(
            ourToken.balanceOf(alice),
            USER_START_BALANCE - transferAmount
        );
        assertEq(
            ourToken.allowance(alice, bob),
            allowanceAmount - transferAmount
        );
    }

    function testAllowanceMoreThanBalanceAndTransfer() public {
        uint256 allowanceAmount = USER_START_BALANCE + 1;

        // Supply Alice some money
        vm.prank(msg.sender);
        ourToken.transfer(alice, USER_START_BALANCE);

        // Alice approves Bob
        vm.prank(alice);
        ourToken.approve(bob, allowanceAmount);

        // Bob transfers from Alice to Charlie
        vm.expectRevert();
        vm.prank(bob);
        ourToken.transferFrom(alice, charlie, allowanceAmount);
    }

    function testTransferFromFailsWithoutAllowance() public {
        uint256 transferAmount = 100 ether;

        vm.expectRevert();
        vm.prank(bob);
        ourToken.transferFrom(alice, bob, transferAmount);
    }

    function testIncreaseAndDecreaseAllowance() public {
        uint256 initialAllowance = 100 ether;
        uint256 additonallAllowance = 50 ether;

        vm.prank(alice);
        ourToken.approve(bob, initialAllowance);

        // Increase allowance
        uint totalAllowance = ourToken.allowance(alice, bob) +
            additonallAllowance;
        vm.prank(alice);
        ourToken.approve(bob, totalAllowance);
        console2.log("allowance(alice, bob) %s", totalAllowance);
        assertEq(ourToken.allowance(alice, bob), totalAllowance);

        // Decrease allowance
        totalAllowance = ourToken.allowance(alice, bob) - additonallAllowance;
        vm.prank(alice);
        ourToken.approve(bob, totalAllowance);
        assertEq(ourToken.allowance(alice, bob), totalAllowance);
    }
}
