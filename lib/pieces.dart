import 'package:flutter/material.dart';
import 'package:tetris_fl/board.dart';
import 'package:tetris_fl/values.dart';

class Piece{
  Tetromino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> position = [];

  // Piece Color
  Color get color{
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  //generate the ints
  void initializePiece(){
    switch (type){
      case Tetromino.I:
        position = [-4,-5,-6,-7];
        break;
      case Tetromino.J:
        position = [-25,-15,-5,-6];
        break;
      case Tetromino.L:
        position = [-26,-16,-5,-6];
        break;
      case Tetromino.O:
        position = [-5,-6,-15,-16];
        break;
      case Tetromino.S:
        position = [-4,-5,-14,-13];
        break;
      case Tetromino.T:
        position = [-4,-14,-24,-15,];
        break;
      case Tetromino.Z:
        position = [-17,-16,-6,-5];
        break;
      default:
    }
  }

  //generate movements
  void movePiece(Direction direction){
    switch (direction) {
      case Direction.left:
        for(int i = 0; i < position.length; i++){
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for(int i = 0; i < position.length; i++){
          position[i] += 1;
        }
        break;
      case Direction.down:
        for(int i = 0; i < position.length; i++){
          position[i] += rowLength;
        }
        break;
      default:
    }
  }

  // rotation of piece
  int rotationState = 1;
  void rotatePiece(){
    List<int> newPosition = [];

    switch(type){
      case Tetromino.L:
        switch(rotationState){
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;

      case Tetromino.J:
        switch(rotationState){
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] + 1,
              position[1] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;

      case Tetromino.I:
        switch(rotationState){
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;

      case Tetromino.O:
        // no rotation
        break;

      case Tetromino.S:
        switch(rotationState){
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;

      case Tetromino.Z:
        switch(rotationState){
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength +2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;

      case Tetromino.T:
        switch(rotationState){
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;
      default:
    }
  }

  bool positionValidation(int position){
    // get row/col position
    int row = (position/rowLength).floor();
    int col = position % rowLength;

    // if position taken
    if(row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition){
    // get row/col position
    bool firstColOcupied = false;
    bool lastColOcupied = false;

    for (var pos in piecePosition) {
      // if any position is taken
      if (!positionValidation(pos)) {
        return false;
      }

      int col = pos % rowLength;

      // check last or first is ocupied
      if(col == 0){ firstColOcupied = true; }
      if(col == rowLength - 1){ lastColOcupied = true; }
    }

    // if there is a piece in the 1st & last col, it is going through the wall
    return !(firstColOcupied && lastColOcupied);
  }
}