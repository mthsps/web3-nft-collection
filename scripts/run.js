const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("NFT contract deployed in:", nftContract.address);
    let txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
    txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
    let count = await nftContract.getTotalNFTsMinted();
    console.log(count.toNumber());
  };
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  runMain();