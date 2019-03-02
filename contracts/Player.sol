pragma solidity 0.5.0;

import './TiCtAcToE.sol';

contract Player
{
    uint256 public wins;
    uint256 public loses;
    string public nickName;
    address public recentCreatedGame;
    address playerOwner;
    address public gm;

    constructor(string memory name, address _gm, address owner) public {
        owner = playerOwner;
        nickName  = name;
        wins = 0;
        loses = 0;
        gm = _gm;

    }

    modifier onlyGame() {
        require(msg.sender == recentCreatedGame, "Only game can use that");
        _;
    }

    modifier onlyGameManager() {
        require(msg.sender == gm, "Only game manager can use that");
        _;
    }


    function incWins() public onlyGame{
        wins++;
    }
    function incLosses() public onlyGame{
        loses++;
    }

    function setLatestGame(address gameAddress) public onlyGameManager{
        recentCreatedGame = gameAddress;
    }
}
