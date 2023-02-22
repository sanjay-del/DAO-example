// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/structs/EnumerableSet.sol';


contract Treasury is Ownable{
    mapping(address => uint256) public fundedAmount;
    mapping(address => uint256) public funder;
    using EnumerableSet for EnumerableSet.AddressSet;
    event FundReceived(address indexed donor, uint256 indexed amount);
    event DistritedAmount(address indexed userAddress, uint256 indexed amount);
    uint256  public contractBalance;
    EnumerableSet.AddressSet private listAddress;

    receive() external payable {}
    function balance() public payable{
        funder[msg.sender] = msg.value;
        contractBalance += msg.value;
        emit FundReceived(msg.sender, msg.value);
    } 
    function treasury() public view returns (uint256){
        return contractBalance;
    }
    function transferfee(address receiver, uint256 _amount) internal{
        (bool txSuccess,) = receiver.call{value: _amount}('');
        require(txSuccess, 'Failed to transfer amount');
    }
    function receivers(address[] memory whiteListAddress,uint256 amounts) public{
        for(uint256 i=0; i<whiteListAddress.length; i++)
        {
            
            transferfee(whiteListAddress[i], amounts);
            contractBalance = contractBalance-amounts;
            fundedAmount[whiteListAddress[i]]= amounts;
            listAddress.add(whiteListAddress[i]);
            emit DistritedAmount(whiteListAddress[i],amounts);
        }

    }
    function fundCalculator() internal view returns(uint256){
         return contractBalance/listAddress.length();
    }
}