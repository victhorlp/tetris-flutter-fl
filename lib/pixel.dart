import 'package:flutter/material.dart';
import 'package:tetris_fl/widgets/simple_text.dart';

class Pixel extends StatelessWidget {
  var colour;
  String i;
  Pixel({super.key, required this.colour, required this.i});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colour, borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.all(1),
      child: SimpleText(text: i)
      ,
    );
  }
}