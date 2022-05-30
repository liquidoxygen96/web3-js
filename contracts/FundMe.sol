//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
 //created priceConverter 'library' to do math and import here using
    using PriceConverter for uint256;

    uint256 public minimumUsd =50 * 1e18;

    //address list to keep track of funders
    address[] public funders;

    //mapping pointer to show value of contribution based on wallet address
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        //minimum fund in usd 
    require(msg.value.getConversionRate() >= minimumUsd, 'Did not send minimum value'); //1 Ether = 1e18 Wei = 1 * 10 ** 18
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = msg.value;
    }
    
}
