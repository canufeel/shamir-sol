pragma solidity 0.5.7;

import "../Lagrange.sol";


contract LagrangeMock {
    function addPolynomials(
        uint8[] memory a,
        uint8[] memory b
    ) public pure returns (uint8[] memory) {
        return Lagrange.addPolynomials(a, b);
    }

    function multiplyPolynomials(
        uint8[] memory a,
        uint8[] memory b
    ) public pure returns (uint8[] memory resultTerms) {
        return Lagrange.multiplyPolynomials(a, b);
    }

    function fullLagrange(
        uint8[] memory xs,
        uint8[] memory fxs
    ) public pure returns (uint8[] memory result) {
        return Lagrange.fullLagrange(xs, fxs);
    }
}
