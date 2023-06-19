// const { expect } = require('chai');
 
// Load compiled artifacts
const DAM = artifacts.require('DigitalAssetMarket');
 
// Start test block
console.log("Hi");
contract('DAM', async function () {
  let DAMDeployed = await DAM.deployed();
  beforeEach(async function () {
    console.log("Before");
    DAMInstance = await DAMDeployed.new(5);
    console.log("After");
    console.log("Share Percent: ",DAMInstance.retrieveSharePercent().toString());
  });
 
  // Test case
  console.log("Hi to you!")
  it('retrieve returns a value previously stored', async function () {
    console.log("Share Percent: ",DAMInstance.retrieveSharePercent().toString());
    expect((await DAMInstance.retrieveSharePercent()).toString()).to.equal('5');
  });
});