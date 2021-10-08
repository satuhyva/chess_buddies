import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gaming_stuff/get_piece_icon.dart';
import '../../providers/game_provider.dart';

class ViewSquare extends StatelessWidget {
  final int row;
  final int column;
  ViewSquare({required this.row, required this.column});

  @override
  Widget build(BuildContext context) {
    final squareColor = getSquareColor(row, column, context);
    final gameProvider = Provider.of<GameProvider>(context);
    final situation = gameProvider.situation;
    final pieceName = situation[row][column];
    final pieceIcon = getPieceIcon(pieceName);

    return Container(
        color: squareColor,
        width: 45,
        height: 45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(pieceIcon, style: const TextStyle(fontSize: 32))],
        ));
  }
}

getSquareColor(row, column, context) {
  final isWhite = isWhiteSquare(row, column);
  if (isWhite) {
    return Theme.of(context).primaryColorLight;
  }
  return Theme.of(context).primaryColorDark;
}

bool isWhiteSquare(int row, int column) {
  if (row % 2 == 0 && column % 2 == 0 || row % 2 != 0 && column % 2 != 0) {
    return true;
  }
  return false;
}
