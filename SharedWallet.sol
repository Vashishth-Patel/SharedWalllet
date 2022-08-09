pragma solidity ^0.8.14;

import "./Allowance.sol";

contract SharedWallet is Allownace{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyRecieved(address indexed _from, uint _amount);

    function withDrawMoney(address payable _to,uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance,"There are not enough funds in wallet");
        if(msg.sender != owner()){
            reduceAllowance(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public onlyOwner override{
        revert("Can't renounce ownership here");
    }

    fallback () external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }
}