pragma solidity ^0.8.0;

contract Bank{
 uint256 bankBalance = 0;
   uint256 id_counter =0;
   User[] users;
    struct User {
        uint id;
        string name;
        string profession;
        string dateOfBirth;
        address wallet;
    }
  mapping (address => uint256) public account_balances;
  mapping ( address => uint256) Id_user;

  modifier OnlyRegistered (){
       require (Id_user[msg.sender] > 0 ,"Account not exist!");
       _;
       }
  function  register_account(string memory new_name ,string memory new_profession ,string memory new_dateOfBirth )  external{

   require (Id_user[msg.sender] > 0 ,"Account already exist!");

   id_counter += 1;

   User memory new_record = User({id: id_counter, name:new_name ,profession:new_profession , dateOfBirth:new_dateOfBirth, wallet: msg.sender});
   users.push(new_record);
   Id_user[msg.sender]=id_counter;
}

  receive () OnlyRegistered external payable{
       account_balances[msg.sender] += msg.value ;
   }

  function withdraw  ( uint amount) OnlyRegistered external{
          account_balances[msg.sender] -= amount;
          payable(msg.sender).transfer(amount);
  } 

  function transfere(uint amount , address accToTransferTo) OnlyRegistered external{
    account_balances[msg.sender] -= amount;
    account_balances[accToTransferTo] += amount;

  }
}
