import 'package:flutter/material.dart';

import '../../gaming_stuff/get_piece_icon.dart';

class Square extends StatefulWidget {
  final int row;
  final int column;
  Square({required this.row, required this.column});
  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  var pieceIsVisible = true;

// TODO: tee tänne se, että haetaan tietoa providerista
  @override
  Widget build(BuildContext context) {
    final squareColor = isWhiteSquare(widget.row, widget.column)
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;

    return Container(
      color: squareColor,
      width: 45,
      height: 45,
    );
  }
}

bool isWhiteSquare(int row, int column) {
  if (row % 2 == 0 && column % 2 == 0 || row % 2 != 0 && column % 2 != 0) {
    return true;
  }
  return false;
}
