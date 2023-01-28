// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.10;
contract FCC {
event ParticipatorUser(address indexed participator);
event Claimers(address indexed claimer);

struct Proposal{
    string name;
    string description;
    uint256 fund;
    uint8 proposalId;
}

mapping(uint256=>Proposal) proposals;



 
 function addProposal( string _name,string _description, uint256 _fund){
    

 }
}