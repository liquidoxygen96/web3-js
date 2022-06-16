//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import './PriceConverter.sol';
contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD =50 * 1e18;

    //address list to keep track of who funds this contract
    address[] public funders;
    //mapping pointer for each address showing their value of contribution
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    
    //gets called as soon as contract is deployed 
    constructor() {
        i_owner = msg.sender;
    }
    
    modifier onlyOwner {
    	require(msg.sender == i_owner, "Not owner, transaction will fail");
    	_;
    	}

    function fund() public payable {
        //minimum fund in usd 
        require(msg.value.getConversionRate() >= MINIMUM_USD, 'Did not send minimum value'); //1 Ether = 1e18 Wei = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    //make sure that only the contract owner(deployer) can call the withdraw function (using a constructor)
    function withdraw() public onlyOwner{
        
        //for loop to index through funders array and make sure the funds are withdrawn properly
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){

            address funder =  funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
            // reset the array by completely blanking the array 
        funders = new address[](0);

        //withdraw
        //Three ways to send native blockchain tokens [transfer, send, call]
        //payable(msg.sender).transfer(address(this.balance));

        //send method 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, 'Send Failed');

        //call method ( preferred method to withdraw funds from a contract
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, 'Call Failed');
    }
}