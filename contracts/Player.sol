pragma solidity 0.5.0;


contract Player
{
    uint256 public wins;
    uint256 public loses;
    string  public name;
    address public playerOwner;

    constructor(string memory name, address owner) public {
        owner = playerOwner;
        nickName  = name;
    }


    function currentGame( bool isWin) internal{
        if(!!isWin){
             inkWins();
        }else{
            incLoses();
        }
    }

    function inkWins() public{}
    function incLoses() public{}



}
