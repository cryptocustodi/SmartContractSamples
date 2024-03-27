// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Checkers {
    // Enum to represent the different states of a square on the checkers board
    enum SquareState { Empty, BlackPiece, RedPiece }

    // Enum to represent the different states of the game
    enum GameState { WaitingForPlayers, BlackTurn, RedTurn, GameOver }

    // Represents a player
    struct Player {
        address addr;
        SquareState pieceType;
    }

    // Represents a game
    struct Game {
        Player[2] players;
        SquareState[8][8] board;
        GameState state;
    }

    mapping(address => Game) public games;

    // Events
    event GameCreated(address indexed player1, address indexed player2);
    event MoveMade(address indexed player, uint8 fromX, uint8 fromY, uint8 toX, uint8 toY);

    // Function to create a new game
    function createGame(address _player2) external {
        require(_player2 != msg.sender, "Player cannot play against themselves");
        require(games[msg.sender].state == GameState.WaitingForPlayers, "You are already in a game");

        games[msg.sender].players[0].addr = msg.sender;
        games[_player2].players[1].addr = _player2;
        games[msg.sender].state = GameState.BlackTurn;

        emit GameCreated(msg.sender, _player2);
    }

    // Function to make a move
    function makeMove(uint8 _fromX, uint8 _fromY, uint8 _toX, uint8 _toY) external {
        Game storage game = games[msg.sender];
        require(game.state != GameState.WaitingForPlayers, "Game not started yet");
        require(game.state != GameState.GameOver, "Game is over");

        Player storage player;
        if (game.state == GameState.BlackTurn) {
            player = game.players[0];
            require(player.addr == msg.sender, "It's not your turn");
        } else {
            player = game.players[1];
            require(player.addr == msg.sender, "It's not your turn");
        }

        require(isValidMove(game.board, player.pieceType, _fromX, _fromY, _toX, _toY), "Invalid move");

        game.board[_toX][_toY] = game.board[_fromX][_fromY];
        game.board[_fromX][_fromY] = SquareState.Empty;

        emit MoveMade(msg.sender, _fromX, _fromY, _toX, _toY);

        // Check for game over conditions and update game state accordingly
        // (not implemented in this example)
    }

    // Function to validate a move
    function isValidMove(
        SquareState[8][8] storage _board,
        SquareState _pieceType,
        uint8 _fromX,
        uint8 _fromY,
        uint8 _toX,
        uint8 _toY
    ) internal view returns (bool) {
        // (not implemented in this example)
        return true;
    }

    //ToDO: handle things like capturing opponent pieces
    //ToDO: kinging pieces
    //ToDO: checking for win conditions
    //ToDO: enforcing turn-taking rules
}
