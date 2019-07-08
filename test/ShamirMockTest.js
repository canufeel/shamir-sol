const ShamirMock = artifacts.require('./ShamirMock.sol');

contract('LagrangeMock', function () {
  describe('addPolynomials', function () {
    it('can add polynomials', async function () {
      const instance = await ShamirMock.new();
      const s1 = [1, 193, 32, 150, 12, 128, 139, 32, 226, 156, 233, 72, 103, 224];
      const s2 = [2, 155, 221, 54, 171, 121, 77, 5, 233, 65, 141, 16, 193, 143];
      const s3 = [3, 18, 152, 204, 203, 150, 234, 5, 124, 178, 22, 52, 194, 78];
      const arg = [s1, s2, s3];
      const maxLen = 2;
      const parsedArg = arg.map(arr => arr.slice(0, maxLen));
      const result = await instance.fromShares(parsedArg);
      assert.equal(result[ 0 ].toNumber(), b[ 0 ]);
      assert.equal(result.length, 1);
    });
  });
});
