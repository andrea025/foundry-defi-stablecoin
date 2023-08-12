// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {DecentralizedStableCoin} from "src/DecentralizedStableCoin.sol";

contract DecentralizedStablecoinTest is Test {
    DecentralizedStableCoin dsc;

    uint256 public constant AMOUNT_TO_MINT = 100 ether;

    function setUp() public {
        dsc = new DecentralizedStableCoin();
    }

    function test_MustMintMoreThanZero() public {
        vm.prank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(this), 0);
    }

    function test_MustBurnMoreThanZero() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), AMOUNT_TO_MINT);
        vm.expectRevert();
        dsc.burn(0);
        vm.stopPrank();
    }

    function test_RevertWhen_UserBurnsMoreThanYouHave() public {
        vm.startPrank(dsc.owner());
        dsc.mint(address(this), AMOUNT_TO_MINT);
        vm.expectRevert();
        dsc.burn(AMOUNT_TO_MINT + 1);
        vm.stopPrank();
    }

    function test_RevertWhen_MintToZeroAddress() public {
        vm.prank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(0), AMOUNT_TO_MINT);
    }
}
