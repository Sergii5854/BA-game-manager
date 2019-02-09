pragma solidity 0.5.0;

import  './TiCtAcToE.sol';

contract GameManager
{
    address[] public players;
    address[] public games;
    address recentCreatedGame;


    constructor() public {

    }

    function askForGame() public{}

    function createGame() internal returns(TiCtAcToE ){
        TiCtAcToE gameNew;
        gameNew = new TiCtAcToE();
        games.push( address(gameNew) );
        return gameNew;
    }

    function createPlayer(address user) internal returns(address){
        address player;
        player = createPlayer(user);
        players.push(player);
        return player;
    }


    function joinGame() public returns(TiCtAcToE ){
        address player;
        TiCtAcToE gameContract;
        player = createPlayer(msg.sender);


        if(recentCreatedGame == address(0)){
            gameContract = createGame();

        }else{
            gameContract =   TiCtAcToE(recentCreatedGame)  ;
            gameContract.setUser(player);
            recentCreatedGame = address(0);
        }

        gameContract.setUser(player);
        return gameContract;

    }


}
