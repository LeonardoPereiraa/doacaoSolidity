// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IERC20 {

  function totalSupply() external view returns (uint256);
  function balanceOf(address account) external view returns (uint256);
  function allowance(address owner, address spender) external view returns (uint256);

  function transfer(address recipient, uint256 amount) external returns (bool);
  function approve(address spender, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Doacao {
  IERC20 public tokenMPE1;
  IERC20 public tokenMPE2;
  address public _owner;

  constructor(address owner,IERC20 MPE1,IERC20 MPE2) public {
    _owner = owner;
    tokenMPE1 = MPE1;
    tokenMPE2 = MPE2;
  }

  function donationMPE1(address  recepient, uint256 value, uint256 cents) public{
    require(msg.sender== _owner);
    uint256 mpe1 = formatValue(value,cents,2 );
    tokenMPE1.transfer(recepient,mpe1);
    
  }
  function donationMPE2(address  recepient, uint256 value, uint256 cents) public{
    require(msg.sender== _owner);
    uint256 mpe2 = formatValue(value,cents,2 );
    tokenMPE2.transfer(recepient,mpe2);
    
  }
  fallback() external payable {
      
  }
  function formatValue(uint256 _value,uint256 _cents, uint256 decimalNumber) internal returns(uint256){
    uint256 value = _value * (10**decimalNumber);
    uint256 cents =  _cents * (10** (decimalNumber-2));
    return value + cents;

  }
   
  function donationETH(address payable recepient, uint256 value,uint256 cents) external{
    require(msg.sender== _owner);
    uint256 eth = formatValue(value,cents,18);
    recepient.transfer( eth );
    
  }
  
  
  function getBalanceEth() external view returns(uint256){
    return address(this).balance;
  }
  function getBalanceMpe1() external view returns(uint256){
    address conta = address(this);
    return tokenMPE1.balanceOf(conta);
  }
  function getBalanceMpe2() external view returns(uint256){
    address conta = address(this);
    return tokenMPE2.balanceOf(conta);
  }
}
