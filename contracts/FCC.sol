// SPDX-License-Identifier: GPL-3.0
import '@openzeppelin/contracts/utils/Counters.sol';

pragma solidity 0.8.10;
contract FCC {
    using Counters for Counters.Counter;

    event ParticipatorUser(address indexed participator);
    event Claimers(address indexed claimer);
    event ProposalAdded(address  indexed _owner, uint256 indexed _proposalId, uint256 funds);
    event ProposalVoted(address indexed _voter,uint256 indexed _proposalId);

    Counters.Counter private _proposalId;

    struct Proposal{
    string name;
    string description;
    uint256 fund;
    uint256 proposalId;
    uint256 votes;
    }

    mapping(uint256=>Proposal) proposals;


    function addProposal( string memory  _name,string  memory _description, uint256 _fund) external{
        uint256 newId = _proposalId.current();
        Proposal storage proposalInfo = proposals[newId];
        proposalInfo.name = _name;
        proposalInfo.description = _description;
        proposalInfo.fund = _fund;
        proposalInfo.proposalId = newId;
        _proposalId.increment();
        emit ProposalAdded(msg.sender, newId, _fund);
    

    }

    function voteProposal(uint256 _proposalid) external{
        Proposal storage proposalInfo = proposals[_proposalid];
        proposalInfo.votes = ++proposalInfo.votes;
        emit ProposalVoted(msg.sender, _proposalid);

    }
 
    function getProposalInfo(uint256 _proposalid) public view returns (Proposal memory proposalInfo){
        return(proposals[_proposalid]);

    }
}