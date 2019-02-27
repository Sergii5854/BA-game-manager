pragma solidity 0.5.0;

import './TiCtAcToE.sol';
import "./Player.sol";

contract GameManager
{
    address owner;
    address[] public players;
    address[] public games;
    address recentCreatedGame;

    // TODO mapping (address => uint8)

    event playerJoinedGame(address gameAddress);

    constructor() public {
        owner = msg.sender;

    }
    modifier olyOwner(){
        require(msg.sender == owner, "only for owner " );
        _;

    }

    function askForGame() public view returns (address[] memory){
        return games;
    }

    function createGame() internal returns (TiCtAcToE){
        TiCtAcToE gameNew;
        gameNew = new TiCtAcToE();
        games.push(address(gameNew));
        return gameNew;
    }

    function createPlayer(address user,  string memory nickName) internal returns (Player){
        Player player;
        player = new Player(nickName, address(this), user);
        players.push(address(player));
        return player;
    }


    function joinGame(string memory nickName) public payable {
        require(msg.value >= 0.04 ether, 'Please pay some value to join game' );

        Player player;
        TiCtAcToE gameContract;
        player = createPlayer(msg.sender , nickName);


        if (recentCreatedGame == address(0)) {
            gameContract = createGame();

        } else {
            gameContract = TiCtAcToE(recentCreatedGame);
            recentCreatedGame = address(0);
        }

        gameContract.setUser(msg.sender);
        emit playerJoinedGame(address(gameContract));

    }

    function closeGame(address gameForClose)olyOwner{
        TiCtAcToE(gameForClose).closeTable();

    }





}
