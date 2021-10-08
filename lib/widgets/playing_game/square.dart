import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gaming_stuff/get_piece_icon.dart';
import '../../providers/game_provider.dart';
import '../../models/piece.dart';
import '../../gaming_stuff/move_is_acceptable.dart';

class Square extends StatefulWidget {
  final int row;
  final int column;
  Square({required this.row, required this.column});
  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  var pieceInOriginalPositionIsVisible = true;
  void changeOriginalPieceVisibility(bool newState) {
    setState(() => pieceInOriginalPositionIsVisible = newState);
  }

  @override
  Widget build(BuildContext context) {
    final squareColor = getSquareColor(widget.row, widget.column, context);
    final gameProvider = Provider.of<GameProvider>(context);
    final situation = gameProvider.situation;
    final pieceName = situation[widget.row][widget.column];
    final iAmWhite = gameProvider.iAmWhite;
    final isMovable = getIsMovable(iAmWhite, pieceName);
    final pieceIcon = getPieceIcon(pieceName);
    final makeAMove = gameProvider.makeAMove;
    return Container(
      color: squareColor,
      width: 45,
      height: 45,
      child: DragTarget<Piece>(
        builder: (context, candidateData, rejectedData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isMovable
                  ? getDraggablePiece(
                      widget.row,
                      widget.column,
                      changeOriginalPieceVisibility,
                      pieceName,
                      pieceIcon,
                      pieceInOriginalPositionIsVisible)
                  : getNonDraggablePiece(pieceIcon)
            ],
          );
        },
        onWillAccept: (incomingPiece) => willAcceptPiece(
            incomingPiece, situation, widget.row, widget.column, iAmWhite),
        onAccept: (incomingPiece) => acceptPiece(
          incomingPiece,
          widget.row,
          widget.column,
          makeAMove,
          context,
        ),
      ),
    );
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

bool getIsMovable(iAmWhite, pieceName) {
  if (pieceName == '') {
    return false;
  }
  if (iAmWhite && isWhitePiece(pieceName) ||
      !iAmWhite && !isWhitePiece(pieceName)) {
    return true;
  }
  return false;
}

bool isWhitePiece(String pieceName) {
  return pieceName.split(' ')[0] == 'white';
}

LongPressDraggable<Piece> getDraggablePiece(row, column,
    changePieceVisibilityState, pieceName, pieceIcon, originalPieceIsVisible) {
  return LongPressDraggable<Piece>(
    data: Piece(
        row: row, column: column, pieceName: pieceName, pieceIcon: pieceIcon),
    onDragStarted: () => changePieceVisibilityState(false),
    maxSimultaneousDrags: 1,
    onDragCompleted: () => changePieceVisibilityState(true),
    onDraggableCanceled: (velocity, offset) => changePieceVisibilityState(true),
    child: Text(originalPieceIsVisible ? pieceIcon : '',
        style: const TextStyle(fontSize: 32)),
    feedback: Text(pieceIcon,
        style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 32,
            color: Colors.black)),
  );
}

getNonDraggablePiece(pieceIcon) {
  return Text(pieceIcon, style: const TextStyle(fontSize: 32));
}

bool willAcceptPiece(Piece? incomingPiece, List<dynamic> situation, int row,
    int column, bool iAmWhite) {
  if (incomingPiece != null) {
    return moveIsAcceptable(incomingPiece, row, column, situation, iAmWhite);
  }
  return false;
}

void acceptPiece(
  Piece incomingPiece,
  int targetRow,
  int targetColumn,
  dynamic makeAMove,
  BuildContext context,
) async {
  makeAMove(incomingPiece, targetRow, targetColumn, context);
}
