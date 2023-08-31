//grid dimensions
import 'package:flutter/material.dart';

int rowLength = 10, 
    colLength = 15;

enum Direction{
  left, right, down
}

enum Tetromino{
  L,J,I,O,S,Z,T
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Colors.orange,
  Tetromino.J: Colors.purple,
  Tetromino.I: Colors.blue,
  Tetromino.O: Colors.grey,
  Tetromino.S: Colors.green,
  Tetromino.T: Colors.yellow,
  Tetromino.Z: Colors.red,
} ;