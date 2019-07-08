const Lagrange = artifacts.require("Lagrange.sol");
const LagrangeMock = artifacts.require("LagrangeMock.sol");
const Shamir = artifacts.require("Shamir.sol");
const ShamirMock = artifacts.require("ShamirMock.sol");

module.exports = function(deployer) {
  deployer.deploy(Lagrange);
  deployer.link(Lagrange, [LagrangeMock, Shamir]);
  deployer.deploy(Shamir);
  deployer.link(Shamir, ShamirMock);
};
