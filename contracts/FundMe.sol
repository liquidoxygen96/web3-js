//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd =50 * 1e18;

    function fund() public payable {
        //minimum fund in usd 
    require(getConversionRate(msg.value) >= minimumUsd, 'Did not send minimum value'); //1 Ether = 1e18 Wei = 1 * 10 ** 18
    }

    //get price of Ethereum/USD: needs 1. ABI 2. Address (0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419)
    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price*1e10);
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
//checks amount of Eth conversion to USD 
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) /1e18;
        return ethAmountInUsd;
    }
    
}
