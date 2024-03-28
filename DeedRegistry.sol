// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract DeedRegistry {
    struct Property {
        address owner;
        string location;
        uint256 value;
        bool exists;
    }

    mapping(bytes32 => Property) public properties; // Mapping of property ID to Property struct

    event PropertyRegistered(
        bytes32 indexed id,
        address indexed owner,
        string location,
        uint256 value
    );
    event OwnershipTransferred(
        bytes32 indexed id,
        address indexed previousOwner,
        address indexed newOwner
    );

    // Function to register a property
    function registerProperty(
        bytes32 _id,
        string memory _location,
        uint256 _value
    ) external {
        require(!properties[_id].exists, "Property already registered");

        properties[_id] = Property({
            owner: msg.sender,
            location: _location,
            value: _value,
            exists: true
        });

        emit PropertyRegistered(_id, msg.sender, _location, _value);
    }

    // Function to transfer ownership of a property
    function transferOwnership(bytes32 _id, address _newOwner) external {
        require(properties[_id].exists, "Property does not exist");
        require(
            properties[_id].owner == msg.sender,
            "Only the owner can transfer ownership"
        );

        address previousOwner = properties[_id].owner;
        properties[_id].owner = _newOwner;

        emit OwnershipTransferred(_id, previousOwner, _newOwner);
    }

    // Function to get property details
    function getPropertyDetails(
        bytes32 _id
    ) external view returns (address, string memory, uint256, bool) {
        Property memory property = properties[_id];
        return (
            property.owner,
            property.location,
            property.value,
            property.exists
        );
    }

    //ToDo: handling multiple owners
    //ToDo: updating property details
    //ToDo: implementing access control
    //ToDo: integrating with external systems for verifying property ownership
}
