// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.10;

import '@openzeppelin/contracts/access/Ownable.sol';

contract Voter is Ownable{

    event VoterRegistered(address indexed voter, address indexed registar);

    event VoterRoleUpdated(address indexed voter, bool status);


    struct VoterInfo{
        string name;
        address account;
        // uint256 voterId;
        bool approved;
    }

    mapping(address=>VoterInfo)  public voters;

    function addVoter(string memory _name,address _account) public onlyOwner(){
        // uint256 _id = _voterId.current();
        VoterInfo storage voterinfo = voters[_account];
        voterinfo.name = _name;
        voterinfo.account =_account;
        emit VoterRegistered(_account,msg.sender);
        // voterinfo.voterId = _id;
        // _voterId.increment();

    }

    function updateVoterRole(address _account,bool status) public {
        VoterInfo storage voterinfo = voters[_account];
        require(voterinfo.account == _account,"Voter not registered");
        voterinfo.approved = status;
        emit VoterRoleUpdated(_account,status);

    }

    function getVoterInfo(address _account) public view returns(VoterInfo memory voterInfo){
        return (voters[_account]);
    }





}
