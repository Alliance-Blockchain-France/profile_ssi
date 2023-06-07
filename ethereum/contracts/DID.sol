// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract DID {
    address owner;
    struct Identity {
        bytes organizationName; 
        bytes internationalOrganizationName;
        bytes organizationIdentifier;
        bytes VAT;
    }
    mapping(address => bool) whitelistAddresses;
    mapping(bytes => Identity) identities;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier isAuthorized() {
        require(whitelistAddresses[msg.sender] == true, "You must be authorized");
        _;
    }

    function addToWhitelist(address memberAddress) public onlyOwner {
        whitelistAddresses[memberAddress] = true;
    }

    function register(bytes memory organizationName, bytes memory internationalOrganizationName, bytes memory organizationIdentifier, bytes memory VAT, bytes[] memory dids) public isAuthorized {
        for(uint i=0; i<dids.length; i++){
            Identity storage identity = identities[dids[i]];
            identity.organizationName = organizationName;
            identity.internationalOrganizationName = internationalOrganizationName;
            identity.organizationIdentifier = organizationIdentifier;
            identity.VAT = VAT;
        }
    }

    function getIdentity(bytes memory did) public view returns(Identity memory) {
        return identities[did];
    }
}