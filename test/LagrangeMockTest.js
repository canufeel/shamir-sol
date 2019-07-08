const LagrangeMock = artifacts.require('./LagrangeMock.sol');

contract('LagrangeMock', function () {
  describe('addPolynomials', function () {
    it('can add polynomials', async function () {
      const instance = await LagrangeMock.new();
      const a = [];
      const b = [247];
      const result = await instance.addPolynomials(a, b);
      assert.equal(result[0].toNumber(), b[0]);
      assert.equal(result.length, 1);
    });
  });

  describe('multiplyPolynomials', function () {
    it('can multiply polynomials', async function () {
      const instance = await LagrangeMock.new();
      const a = [247, 246];
      const b = [140, 141];
      const expected = [1, 123, 123];
      const result = await instance.multiplyPolynomials(a, b);
      result.forEach((item, idx) => {
        assert.equal(item.toNumber(), expected[idx]);
      });
      assert.equal(result.length, expected.length);
    });
  });

  describe('fullLagrange', function () {
    it('full lagrange returns proper results', async function () {
      const instance = await LagrangeMock.new();
      const xs = [1, 2, 3];
      const fxs = [159, 245, 34];
      const expected = [72, 34, 245];
      const result = await instance.fullLagrange(xs, fxs);
      result.forEach((item, idx) => {
        assert.equal(item.toNumber(), expected[idx]);
      });
      assert.equal(result.length, expected.length);
    });
  });
});