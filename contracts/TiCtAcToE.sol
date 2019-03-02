pragma solidity 0.5.0;
import './Player.sol';

contract TiCtAcToE
{
    uint8 leftMoves;
    bool public  isReady;
    address public activeUser;
    address public gm;
    address public player1; // 1 = o
    address public player2; // 7 = x
    uint8[][] public board;
    address public winner = address(0);
    uint256 public lastTime;

    event UserMoved(address  player,  uint  col, uint  row  ) ;

    constructor() public {
        gm = msg.sender;
        isReady = true;
        leftMoves = 9;
        initArray();
    }

    modifier onlyActiveUser() {
        require(msg.sender == activeUser, "Only active user can make a move");
        _;
    }
    modifier onlyGameManager() {
        require(msg.sender == gm, "Only active gm can make a move");
        _;
    }

    function initArray() internal  {
        board = new uint8[][](3);
        for (uint8 i = 0; i < 3; i++) {
            uint8[] memory temp = new uint8[](3);
            for(uint8 j = 0; j < 3; j++){
                temp[j] = 0;
            }
            board[i] = temp;
        }
    }

    function setUser(address user) public{
        require(
            player1 == address(0) ||
            player2 == address(0),
            "two players are in the game"
        );

        if(player1 == address(0)){
            player1 = user;
        }else if(player2 == address(0)){
            player2 = user;
            activeUser = player2;
            isReady = false;
            for(uint8 i = 0; i < 3; i++ ){
                for(uint8 j = 0; j < 3; j++ ){
                    board[i][j] = 0;
                }
            }
        }
    }

    function move(uint8 col, uint8 row) public onlyActiveUser  {
        require(isReady == false, "game is not ready");
        require(winner == address(0), "Winner is set now ");
        require(leftMoves > 0, "there is no moves left");
        require(row < 3 && col < 3, "illegal move");
        require(board[col][row] == 0, "the cell is already used by another player");

        lastTime = block.timestamp;
        leftMoves = leftMoves - 1;

        if(msg.sender == player1 ){
            board[col][row] = board[col][row] + 1;
            activeUser = player2;



        } else if(msg.sender == player2) {
            board[col][row] = board[col][row] + 7;
            activeUser = player1;
        }

        if(checkWinner() || leftMoves == 0){
            reward();
        }

        emit UserMoved(activeUser ,col , row );
    }

    function checkWinner() internal returns(bool){

        //[(0,0),(0,1),(0,2)]
        //[(1,0),(1,1),(1,2)]
        //[(2,0),(2,1),(2,2)]

        uint8 mainDiagSum = 0;
        uint8 diagSum = 0;
        for (uint8 i = 0; i < 3; i++) {
            uint8 rowSum = 0;
            uint8 colSum = 0;
            for(uint8 j = 0; j < 3; j++){
                rowSum += board[i][j];
                colSum += board[j][i];
                if (i == j) {
                    mainDiagSum = mainDiagSum + board[i][i];
                }
                if (i + j == 2) {
                    diagSum += board[j][i];
                }
            }
            // check rows and columns
            if (rowSum == 3 || colSum == 3) {
                winner = player1;
                return true;
            } else if (rowSum == 21 || colSum == 21) {
                winner = player2;
                return true;
            }
        }
        // check diagonals
        if (mainDiagSum == 3 || diagSum == 3) {
            winner = player1;
            return true;
        } else if (mainDiagSum == 21 || diagSum == 21) {
            winner = player2;
            return true;
        }
        return false;
    }


    function reward() internal{

        if(winner == player1){
            Player(player1).incWins();
            Player(player2).incLosses();
        }else if(winner == player2){
            Player(player2).incWins();
            Player(player1).incLosses();
        }else{
            Player(player2).incLosses();
            Player(player1).incLosses();
        }
    }

    function closeTable() public{
        if(winner == player1){
            winner == player2;
        }else if(winner == player2){
           winner == player1;
        }
        reward();
    }

    function checkTime() public{
        if(block.timestamp - lastTime >= 60 ){
            closeTable();
        }

    }

}
