// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CarDealership {
    struct Car {
        string make;
        string model;
        uint year;
        uint price;
        bool exists;
    }

    mapping(uint => Car) private cars;
    uint private nextCarId;
    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(address _owner) {
        require(_owner != address(0), "Owner address cannot be the zero address");
        owner = _owner;
        nextCarId = 1; // Start car IDs from 1
    }

    // Function to add a new car
    function addCar(string memory make, string memory model, uint year, uint price) public {
        // Ensure only the contract owner can add new cars
        if (msg.sender != owner) {
            revert("Only the owner can add new cars");
        }
    
        // Check that all required parameters are provided
        require(bytes(make).length > 0, "Car make must not be empty");
        require(bytes(model).length > 0, "Car model must not be empty");
        require(year > 0, "Car year must be greater than zero");
        require(price > 0, "Car price must be greater than zero");
    
        // Store the new car in the cars mapping
        cars[nextCarId] = Car(make, model, year, price, true);
        nextCarId++;
    }

    // Function to get a car by its ID
    function getCar(uint carId) public view returns (string memory, string memory, uint, uint) {
        require(carId > 0 && carId < nextCarId, "Car ID is invalid");

        Car storage car = cars[carId];
        require(car.exists, "Car does not exist");

        return (car.make, car.model, car.year, car.price);
    }

    // Function to update a car
    function updateCar(uint carId, string memory make, string memory model, uint year, uint price) public onlyOwner {
        require(carId > 0 && carId < nextCarId, "Car ID is invalid");
        Car storage car = cars[carId];
        require(car.exists, "Car does not exist");

        require(bytes(make).length > 0, "Car make must not be empty");
        require(bytes(model).length > 0, "Car model must not be empty");
        require(year > 0, "Car year must be greater than zero");
        require(price > 0, "Car price must be greater than zero");

        car.make = make;
        car.model = model;
        car.year = year;
        car.price = price;
    }

    // Function to remove a car
    function removeCar(uint carId) public onlyOwner {
        require(carId > 0 && carId < nextCarId, "Car ID is invalid");
        Car storage car = cars[carId];
        require(car.exists, "Car does not exist");

        delete cars[carId];
    }

    // Function to check contract invariants (example of assert)
    function checkInvariant() public view {
        assert(owner != address(0));
    }

    // Function to transfer ownership of the contract
    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner == address(0)) {
            revert("New owner cannot be the zero address");
        }
        owner = newOwner;
    }
}
