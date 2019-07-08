pragma solidity 0.5.7;

import "./Lagrange.sol";


library Shamir {
    function sharesByIdx(
        bytes memory shares,
        uint256 idx
    ) internal pure returns (
        uint8[] memory result
    ) {
        assembly {
            let sharesLen := mload(add(shares, 0x20))
            let sharesLenBytes := mload(shares)
            let offset := add(mul(idx, div(sub(sharesLenBytes, 0x20), sharesLen)), 0x40)
            result := add(shares, offset)
        }
    }

    function fromShares(
        bytes memory shares
    ) public pure returns (
        uint8[] memory result
    ) {
        uint256 sharesLen;
        assembly {
            sharesLen := mload(add(shares, 0x20))
        }
        uint256 rounds = sharesByIdx(
            shares,
            0
        ).length - 1;
        uint8[] memory xs = new uint8[](sharesLen);
        for (uint256 shIdx = 0; shIdx < sharesLen; shIdx++) {
            xs[shIdx] = sharesByIdx(
                shares,
                shIdx
            )[0];
        }
        for (uint256 byteIdx = 0; byteIdx < rounds; byteIdx++) {
            uint8[] memory fxs = new uint8[](sharesLen);
            for (uint256 sh = 0; sh < sharesLen; sh++) {
                fxs[sh] = sharesByIdx(
                    shares,
                    sh
                )[1 + byteIdx];
            }
            uint8[] memory poly = Lagrange.fullLagrange(xs, fxs);
            result[byteIdx] = poly[0];
        }
    }
}