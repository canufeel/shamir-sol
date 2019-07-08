pragma solidity 0.5.7;
pragma experimental ABIEncoderV2;

import "../Shamir.sol";


contract ShamirMock {
    function fromShares(uint8[][] memory shares) public pure returns (uint8[] memory result) {
        return Shamir.fromShares(shares);
    }
}
