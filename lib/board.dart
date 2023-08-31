import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_fl/pieces.dart';
import 'package:tetris_fl/pixel.dart';
import 'package:tetris_fl/values.dart';
import 'package:tetris_fl/widgets/simple_text.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength, 
  (i) => List.generate(
    rowLength, 
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //grid dimensions
  bool gameover = false;
  int rowLength = 10, 
      colLength = 15,
      currentScore = 0;

  //debug current Tetris piece
  Piece currentPiece = Piece(type: Tetromino.O);

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame(){
    currentPiece.initializePiece();

    // Frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate){
    Timer.periodic(frameRate, (timer) { 
      setState(() {
        clearLines();
        checkLanding();

        if (gameover) {
          timer.cancel();
          gameOverModal();
        }

        currentPiece.movePiece(Direction.down);
      });
    });
  }

  bool checkCollision(Direction direction){
    // Through each position of the current piece
    for (var i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // Adjust col/row based on direction
      if (direction == Direction.left) { col -= 1; }
      else if (direction == Direction.right) { col += 1; }
      else if (direction == Direction.down) { row += 1; }

      // if it is out of bounds
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
    }

    // no collision detected
    return false;
  }

  void checkLanding(){
    if(checkCollision(Direction.down) || checkLanded()){
      for (var i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
    // once landed, create new piece
    createNewPiece();
    }
  }

  bool checkLanded() {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

  void createNewPiece(){
    // random object to generate random tetromino types
    Random rand = Random();

    Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    // Avaluate if piece is at the very top goes to game over
    if (isGameOver()) {
      gameover = true;
    }
  }

  void moveLeft(){
    // Validate if move is valid
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight(){
    // Validate if move is valid
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines(){
    for (var row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (var col = 0; col < rowLength; col++) {
        if(gameBoard[row][col] == null){
          rowIsFull = false;
          break;
        }
      }

      if(rowIsFull){
        for (var r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }

    }
  }

  bool isGameOver(){
    for (var col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  // void gameOverModal(){
  //   showAboutDialog(
  //     context: context,
  //     children: [
  //       AlertDialog(
  //         title: SimpleText(text: "Game Over!", size: 32,),
  //         content: SimpleText(text: "Final score: $currentScore", size: 24,),
  //         actions: [
  //           TextButton(
  //             onPressed: (){
  //               // reset game
  //               gameBoard = List.generate(
  //                 colLength, 
  //                 (i) => List.generate(
  //                   rowLength, 
  //                   (j) => null,
  //                 ),
  //               );

  //               gameover = false;
  //               currentScore = 0;

  //               createNewPiece();
  //               startGame();

  //               Navigator.pop(context);
  //             },
  //             child: SimpleText(text: "Play Again")
  //           ), 
  //         ],
  //       )
  //     ]
  //   );
  // }

  Future<void> gameOverModal() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SimpleText(
            text: "Game Over!", 
            size: 32, 
            textColor: Colors.black,
          ),
          content: SimpleText(
            text: "Final score: $currentScore", 
            size: 24,
            textColor: Colors.black,
          ),
          actions: [
            TextButton(
              onPressed: (){
                // reset game
                gameBoard = List.generate(
                  colLength, 
                  (i) => List.generate(
                    rowLength, 
                    (j) => null,
                  ),
                );

                gameover = false;
                currentScore = 0;

                createNewPiece();
                startGame();

                Navigator.pop(context);
              },
              child: SimpleText(
                text: "Play Again", 
                textColor: Colors.indigo,
              )
            ), 
          ],
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          gridTetris(),
          SimpleText(
            text: "Score: $currentScore", 
            textColor: Colors.white,
            size: 20,
          ),
          gameControls()
        ],
      )
    );
  }

  Widget gridTetris(){
    return Expanded(
      child: GridView.builder(
        itemCount: rowLength * colLength,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength), 
        itemBuilder: (context, index) {
          int row = (index / rowLength).floor();
          int col = index % rowLength;

          // Current Piece
          if(currentPiece.position.contains(index)){
            return Pixel(colour: currentPiece.color, i: index.toString(),);
          }
          // Landed pieces
          else if(gameBoard[row][col] != null){
            final Tetromino? tetrominoType = gameBoard[row][col];
            return Pixel(colour: tetrominoColors[tetrominoType], i: '',);
          }
          // Blank
          else{
            return Pixel(colour: Colors.grey[900], i: index.toString(),);
          }
        }
      ) 
    );
  }

  Widget gameControls(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 80, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: moveLeft, 
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.indigo, 
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back_ios, 
                color: Colors.white,
                size: 32,
              )
            ),
          ),
          InkWell(
            onTap: rotatePiece, 
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.amber[900], 
              alignment: Alignment.center,
              child: const Icon(
                Icons.rotate_right,
                color: Colors.white,
                size: 32,
              )
            ),
          ),
          InkWell(
            onTap: moveRight, 
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.indigo, 
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 32,
              )
            ),
          ),
        ],
      ),
    );
  }
}