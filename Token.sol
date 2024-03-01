// SPDX-License-Identifier: MIT
pragma solidity 0.8.*;

/*
       REQUIREMENTS
    1. Your contract will have public variables that store the details about your coin (Token Name, Token Abbrv., Total Supply)
    2. Your contract will have a mapping of addresses to balances (address => uint)
    3. You will have a mint function that takes two parameters: an address and a value. 
       The function then increases the total supply by that number and increases the balance 
       of the “sender” address by that amount
    4. Your contract will have a burn function, which works the opposite of the mint function, as it will destroy tokens. 
       It will take an address and value just like the mint functions. It will then deduct the value from the total supply 
       and from the balance of the “sender”.
    5. Lastly, your burn function should have conditionals to make sure the balance of "sender" is greater than or equal 
       to the amount that is supposed to be burned.
*/

contract MyToken {

    // public variables here
    struct token{
        string Name;
        string Abbrv;
        uint   TotalSupply;
    }
    token public coin;
    
    // mapping variable here
    mapping(address=>uint256) private balances;
    mapping(address => mapping(address=>bool)) private isPresent;

    function init() external{
        coin.Name = "borjalTokenExer";
        coin.Abbrv = "borjalTokEx";
    }
    // mint function
    function mint(uint _val) external{
        address _addr = msg.sender;
        balances[_addr] += _val;
        coin.TotalSupply += _val;
        isPresent[_addr][address(this)] = true;
    }
    function mint(address _addr, uint _val) external{
        balances[_addr] += _val;
        coin.TotalSupply += _val;
        isPresent[_addr][address(this)] = true;
    }
    // burn function
    function burn (uint _val) external returns (string memory){
        address _addr = msg.sender;
        if(isPresent[_addr][address(this)]){
            if(balances[_addr] >= _val){
                balances[_addr] -= _val;
                coin.TotalSupply -= _val;
                if(balances[_addr] == 0){
                    isPresent[_addr][address(this)] = false;
                    delete balances[_addr];
                }
                return string.concat("Balance was burned by ",string(abi.encode(_val)));
            }else if(balances[_addr] < _val){
                return "Error: Balance is less than amount to be burned.";
            }
        }
        return "Error: Address not found.";
    }
    function burn(address _addr, uint _val) external returns (string memory){
        if(isPresent[_addr][address(this)]){
            if(balances[_addr] >= _val){
                balances[_addr] -= _val;
                coin.TotalSupply -= _val;
                if(balances[_addr] == 0){
                    isPresent[_addr][address(this)] = false;
                    delete balances[_addr];
                }
                return string.concat("Balance was burned by ",string(abi.encode(_val)));
            }else if(balances[_addr] < _val){
                return "Error: Balance is less than amount to be burned.";
            }
        }
        return "Error: Address not found.";
    }
}