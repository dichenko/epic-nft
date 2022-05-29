import React from "react";

export default function SuccessAlert(props) {
  console.log(props.addr);
  console.log(props.id);
  
  return (
    <div className="alert success">
           Hey there! We've minted your NFT and sent it to your wallet. It may be blank right now. It can take a max of 10 min to show up on OpenSea. 
      
      <a href={'https://testnets.opensea.io/assets/rinkeby/'+props.addr+'/'+props.id} >Check out your new NFT on OpenSea</a>
      
     </div>
  );
}

