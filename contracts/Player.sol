pragma solidity 0.5.0;

import './TiCtAcToE.sol';

contract Player
{
    uint256 public wins;
    uint256 public loses;
    string public nickName;
    address recentCreatedGame;
    address playerOwner;
    address _gm;

    constructor(string memory name, address gm, address owner) public {
        owner = playerOwner;
        nickName  = name;
        wins = 0;
        loses = 0;
        _gm = gm;
    }


    modifier onlyGame() {
        require(msg.sender == recentCreatedGame, "Only game can use that");
        _;
    }

    modifier onlyGameManager() {
        require(msg.sender == _gm, "Only game manager can use that");
        _;
    }


    function inkWins() public onlyGame{
        wins++;
    }
    function incLoses() public onlyGame{
        loses++;
    }

    function setLatestGame(address gameAddress) public onlyGameManager{
        recentCreatedGame = gameAddress;
    }
}
