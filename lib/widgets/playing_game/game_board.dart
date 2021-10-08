import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './square.dart';
import '../../providers/game_provider.dart';
import './view_square.dart';

class GameBoard extends StatelessWidget {
  getSquares(bool movable) {
    List<Widget> squaresList = [];
    for (var rowIndex = 0; rowIndex < 8; rowIndex++) {
      List<Widget> row = [];
      for (var columnIndex = 0; columnIndex < 8; columnIndex++) {
        if (movable) {
          row.add(Square(row: rowIndex, column: columnIndex));
        } else {
          row.add(ViewSquare(row: rowIndex, column: columnIndex));
        }
      }
      squaresList.add(Row(children: row));
    }
    return Column(
      children: squaresList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final isMyTurn = gameProvider.isMyTurn;
    if (!isMyTurn) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [getSquares(false)],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [getSquares(true)],
    );
  }
}
