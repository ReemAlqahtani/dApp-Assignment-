pragma solidity >=0.7.0 <0.9.0;

contract firstContract {

 string   private fullName ;
    function getString () external  view returns (string memory) {

     return fullName;

 }

    function setString (string memory name)public {
        fullName = name ;
    }

}
