// SPDX-License-Identifier: MIT 
pragma solidity ^0.6.0;

contract HotelRoom{

    enum Status {Vacant, Occupied}
    Status currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() public {
        owner = msg.sender;
        currentStatus = Status.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Status.Vacant, "Currently occupied.");
        _;
    }

    modifier costs(uint _amount){
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Status.Occupied;
        owner.transfer(msg.value);
        emit Occupy
        (msg.sender, msg.value);
    }
}