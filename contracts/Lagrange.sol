pragma solidity 0.5.7;

import "gf256-sol/contracts/GF256.sol";


library Lagrange {

    using GF256 for uint8;

    function addPolynomials(
        uint8[] memory a,
        uint8[] memory b
    ) public pure returns (uint8[] memory) {
        uint256 len;
        if (a.length < b.length) {
            len = b.length;
        } else {
            len = a.length;
        }

        uint8[] memory results = new uint8[](len);

        for (uint256 i = 0; i < len; i++) {
            uint8 aOrZero = a.length > i ? a[i] : 0;
            uint8 bOrZero = b.length > i ? b[i] : 0;
            results[i] = aOrZero.gf256Add(bOrZero);
        }

        return results;
    }

    function multiplyPolynomials(
        uint8[] memory a,
        uint8[] memory b
    ) public pure returns (uint8[] memory resultTerms) {
        uint256 padding = 0;
        for (uint256 i = 0; i < b.length; i++) {
            uint8[] memory currentValues = new uint8[](a.length + padding);
            for (uint256 k = 0; k < padding; k++) {
                currentValues[k] = 0;
            }
            for (uint256 j = 0; j < a.length; j++) {
                uint8 aTerm = a[j];
                uint8 bTerm = b[i];
                currentValues[j + padding] = aTerm.gf256Mul(bTerm);
            }
            resultTerms = addPolynomials(resultTerms, currentValues);
            padding += 1;
        }
    }

    function fullLagrange(
        uint8[] memory xs,
        uint8[] memory fxs
    ) public pure returns (uint8[] memory result) {
        uint256 len = fxs.length;
        for (uint256 i = 0; i < len; i++) {
            uint8[] memory thisPoly = new uint8[](1);
            thisPoly[0] = 1;
            for (uint256 j = 0; j < len; j++) {
                if (i == j) {
                    continue;
                }
                uint8 denominator = xs[i].gf256Sub(xs[j]);
                uint8[] memory thisTerm = new uint8[](2);
                thisTerm[0] = xs[j].gf256Div(denominator);
                thisTerm[1] = uint8(1).gf256Div(denominator);
                thisPoly = multiplyPolynomials(thisPoly, thisTerm);
            }
            if (fxs.length + 1 >= i) {
                uint8[] memory multiple = new uint8[](1);
                multiple[0] = fxs[i];
                thisPoly = multiplyPolynomials(thisPoly, multiple);
            }
            result = addPolynomials(result, thisPoly);
        }
    }
}