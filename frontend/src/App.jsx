import React, { useEffect, useState } from "react";
import "./styles/App.css";
import twitterLogo from "./assets/twitter-logo.svg";
import { ethers } from "ethers";
import myEpicNft from "./utils/BulletNFT.json";
import SuccessAlert from "./components/SuccessAlert";

const TWITTER_HANDLE = "dichenko";
const TWITTER_LINK = `https://twitter.com/${TWITTER_HANDLE}`;
const OPENSEA_LINK =
  "https://testnets.opensea.io/collection/bullet1996-d2e0crcwg8";
const TOTAL_MINT_COUNT = 50;
const CONTRACT_ADDRESS = "0xC1CA33789626978592cE9f2eeD138B7d4Ff093A0";

const App = () => {
  const [currentAccount, setCurrentAccount] = useState("");
  const [loader, setLoader] = useState(false);
  const [newNftDone, setNewNftDone] = useState(false);
  const [tokenId, setTokenId] = useState();

  useEffect(() => {
    checkIfWalletIsConnected();
  }, []);

  const checkIfWalletIsConnected = async () => {
    const { ethereum } = window;
    if (!ethereum) {
      console.log("Make sure you have metamask!");
      return;
    } else {
      console.log("We have the ethereum object", ethereum);
    }

    const accounts = await ethereum.request({ method: "eth_accounts" });
    let chainId = await ethereum.request({ method: "eth_chainId" });
    console.log("Connected to chain " + chainId);
    const rinkebyChainId = "0x4";
    if (chainId !== rinkebyChainId) {
      alert("You are not connected to the Rinkeby Test Network!");
    }

    if (accounts.length !== 0) {
      const account = accounts[0];
      console.log("Found an authorized account:", account);
      setCurrentAccount(account);
      setupEventListener();
    } else {
      console.log("No authorized account found");
    }
  };

  const connectWallet = async () => {
    try {
      const { ethereum } = window;
      if (!ethereum) {
        alert("Get MetaMask!");
        return;
      }
      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      });

      console.log("Connected", accounts[0]);
      setCurrentAccount(accounts[0]);
      setupEventListener();
    } catch (error) {
      console.log(error);
    }
  };

  const setupEventListener = async () => {
    try {
      const { ethereum } = window;

      if (ethereum) {
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectedContract = new ethers.Contract(
          CONTRACT_ADDRESS,
          myEpicNft.abi,
          signer
        );

        connectedContract.on("NewBullet", (from, newtokenId) => {
          setTokenId(newtokenId.toNumber());
          console.log(from, tokenId);
          setLoader(false);
          setNewNftDone(true);
        });

        console.log("Setup event listener!");
      } else {
        console.log("Ethereum object doesn't exist!");
      }
    } catch (error) {
      console.log(error);
    }
  };

  const renderNotConnectedContainer = () => (
    <>
      <button
        onClick={connectWallet}
        className="cta-button connect-wallet-button"
      >
        Connect to Wallet
      </button>
      <div>
        <p className="whitetext">Connect wallet in Rinkeby network</p>
      </div>
    </>
  );

  const renderConnectedContainer = () => (
    <>
      {!loader && (
        <button
          onClick={askContractToMintNft}
          className="cta-button mint-button"
        >
          Mint NFT
        </button>
      )}
      {loader && (
        <div className="alert warning">
          Confirm transaction and wait 10-60 sec
        </div>
      )}

      {newNftDone && (
        <div className="alert success">
          <p>Hey there! </p>
          <p>
            We've minted your NFT and sent it to your wallet. It may be blank
            right now. It can take a max of 10 min to show up on OpenSea.
          </p>
          <a
            href={
              "https://testnets.opensea.io/assets/rinkeby/" +
              CONTRACT_ADDRESS +
              "/" +
              tokenId
            }
            target="_blank"
          >
            Check out your new NFT on OpenSea
          </a>
        </div>
      )}

      <div className="">
        <p className="whitetext">
          Connected with{" "}
          <b>
            {currentAccount.substr(0, 6)} ... {currentAccount.substr(38)}
          </b>
        </p>
      </div>
    </>
  );

  const askContractToMintNft = async () => {
    try {
      const { ethereum } = window;

      if (ethereum) {
        setLoader(true);
        setNewNftDone(false);
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectedContract = new ethers.Contract(
          CONTRACT_ADDRESS,
          myEpicNft.abi,
          signer
        );

        console.log("Going to pop wallet now to pay gas...");
        let nftTxn = await connectedContract.makeBulletNFT();

        console.log("Mining...please wait.");
        await nftTxn.wait();

        console.log(
          `Mined, see transaction: https://rinkeby.etherscan.io/tx/${nftTxn.hash}`
        );
      } else {
        console.log("Ethereum object doesn't exist!");
      }
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <div className="App">
      <div className="container">
        <div className="header-container">
          <p className="header gradient-text">Bullet movie NFT Collection</p>
          <p className="sub-text">Each unique. Each beautiful.</p>
          <p className="sub-text">Bullet (1996)</p>
          {currentAccount === ""
            ? renderNotConnectedContainer()
            : renderConnectedContainer()}
        </div>
        <div className="main-container">
          <div className="gallery">
            <div className="picture">
              <img
                src="src/img/001.png"
                alt="Bullet NFT _01"
                width="250"
                title=""
              />
            </div>
            <div className="picture">
              <img
                src="src/img/002.png"
                alt="Bullet NFT _02"
                width="250"
                title=""
              />
            </div>
            <div className="picture">
              <img
                src="src/img/003.png"
                alt="Bullet NFT _03"
                width="250"
                title=""
              />
            </div>
          </div>

          <form
            target="_blank"
            action="https://testnets.opensea.io/collection/bullet1996-d2e0crcwg8"
          >
            <input
              type="submit"
              className="cta-button opensea-button"
              value="Explore Bullet NFT collection"
            />
          </form>
        </div>

        <div className="footer-container">
          <img alt="Twitter Logo" className="twitter-logo" src={twitterLogo} />
          <a
            className="footer-text"
            href={TWITTER_LINK}
            target="_blank"
            rel="noreferrer"
          >{`Tweet me @${TWITTER_HANDLE}`}</a>
        </div>
      </div>
    </div>
  );
};

export default App;
