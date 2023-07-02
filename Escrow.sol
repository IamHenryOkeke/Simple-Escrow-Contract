// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
    address public depositor; 
    address public beneficiary; 
    address public arbiter;
    bool public isApproved = false; 
    event Approved(uint value);

    constructor(address _arbiterAddress, address _beneficiaryAddress) payable {
        depositor = msg.sender;
        beneficiary = _beneficiaryAddress;
        arbiter = _arbiterAddress;
    }

    function approve() public payable{
        // reverts if the caller isn't the arbiter
        require(msg.sender == arbiter, "Not the arbiter");
        uint balance = address(this).balance;
        (bool sent, ) = beneficiary.call{value: balance}("");
        require(sent, "Failed to send Ether");
        isApproved = true;
        emit Approved(balance);
    }
}
