// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

//ignore: must_be_immutable
class SimpleText extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;
  final double height;
  final TextDecoration decoration;
  final double decorationThickness;
  final Offset offset;
  double? size;
  String? family;
  FontWeight? weight;
  final bool disableDefaultColor;
  final TextOverflow overflow;
  final bool oneLine;
  final double letterSpacing;

  SimpleText({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.textAlign = TextAlign.left,
    this.height = 1.5,
    this.decoration = TextDecoration.none,
    this.decorationThickness = 0,
    this.offset = const Offset(0, 0),
    this.size = 12,
    this.weight = FontWeight.w400,
    this.disableDefaultColor = false,
    this.overflow = TextOverflow.visible,
    this.oneLine = false,
    this.letterSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = disableDefaultColor
        ? TextStyle(
            fontSize: size,
            fontWeight: weight,
            height: height,
            decoration: decoration,
            decorationColor: textColor,
            decorationThickness: decorationThickness,
            shadows: [Shadow(color: textColor, offset: offset)],
            letterSpacing: letterSpacing,
          )
        : TextStyle(
            color:
                offset != const Offset(0, 0) ? Colors.transparent : textColor,
            fontSize: size,
            fontWeight: weight,
            height: height,
            decoration: decoration,
            decorationColor: textColor,
            decorationThickness: decorationThickness,
            shadows: [Shadow(color: textColor, offset: offset)],
            letterSpacing: letterSpacing,
          );

    return oneLine == false
        ? Text(
            text,
            style: textStyle,
            textAlign: textAlign,
            overflow: overflow,
          )
        : Text(
            text,
            style: textStyle,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: 1,
          );
  }
}
