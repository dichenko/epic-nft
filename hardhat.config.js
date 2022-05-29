
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config({ path: ".env" });

module.exports = {
  solidity: '0.8.1',
  networks: {
    rinkeby: {
      url: process.env.ALCHEMY_API_KEY_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan:{apiKey:process.env.ETHERSCAN_API_KEY}
};