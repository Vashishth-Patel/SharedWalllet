pragma solidity ^0.8.14;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allownace is Ownable{

    using SafeMath for uint;
    event AllownaceChanged(address indexed _forWho,address indexed _fromWhom,uint _oldAmount,uint _newAmount);

    mapping (address => uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner{
        emit AllownaceChanged(_who,msg.sender,allowance[_who],_amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(msg.sender == owner() || allowance[msg.sender] >= _amount,"You are not allowed");
        _;
    }

    function reduceAllowance(address _who,uint _amount) internal{
        emit AllownaceChanged(_who,msg.sender,allowance[_who],allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
}
