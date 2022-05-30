//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//define contract - similar to class in javascript
contract SimpleStorage {
    //types in solidity: boolean, uint, int, address, bytes
    uint256 favoriteNumber; //initialized to 0

    //mapping: looking through an array
    mapping(string => uint256) public nameToFavoriteNumber;
    //struct
    struct People {
        uint256 favoriteNumber;
        string name;
    }
//array
// uint256[] public favoriteNumberList
People[] public people;

    //functions: execute certain steps
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        }

    //retrieve using either view or pure to dissallow state change ie no gas x
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    // push function
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        //People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        //people.push(newPerson);
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name]= _favoriteNumber;
    }
    
}