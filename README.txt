Hello World
This Solidity program is a simple "Create a Token" program that demonstrates the basics of getting started with solidity.

Description
This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract fulfills the following project requirements:
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

Getting Started
Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., CreateToken.sol). Copy and paste the following code into the file:

pragma solidity 0.8.*;

contract MyToken {

    // public variables here
    struct token{
        string Name;
        string Abbrv;
        uint   TotalSupply;
    }
    token public coin;
    
    // mapping variable here
    mapping(address=>uint256) public balances;
    mapping(address => mapping(address=>bool)) public isPresent;

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
}
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.4" (or another compatible version), and then click on the "Compile CreateToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "CreateToken" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the init function. Click on the "MYTOKEN" contract in the left-hand sidebar, and then click on the "init" function. Mint Tokens Finally, click on the "transact" button to execute the function and retrieve the "Hello World!" message.

Authors
Gabriel Luis G. Borjal
discord: .gaboy

License
This project is licensed under the MIT License - see the LICENSE.md file for details