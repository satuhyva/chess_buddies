import '../models/piece.dart';

bool moveIsAcceptable(Piece incomingPiece, int targetRow, int targetColumn,
    List<dynamic> piecePositions, bool iAmWhite) {
  final startingRow = incomingPiece.row;
  final startingColumn = incomingPiece.column;
  // print('${startingRow}');
  // print('${startingColumn}');
  // print('${targetRow}');
  // print('${targetColumn}');

  if (startingRow == targetRow && startingColumn == targetColumn) {
    return false;
  }
  final incomingPieceParts = incomingPiece.pieceName.split(' ');

  final incomingPieceColor = incomingPieceParts[0];
  final incomingPieceType = incomingPieceParts[1];

  final targetPieceParts = piecePositions[targetRow][targetColumn].split(' ');
  if (targetPieceParts == 2) {
    final targetPieceColor = targetPieceParts[0];
    if (incomingPieceColor == targetPieceColor) {
      return false;
    }
  }
  // print(targetPieceParts);
  // print('${incomingPieceColor}');
  // print('${incomingPieceType}');
  // print('${targetPieceColor}');

  var isAllowed = false;
  if (incomingPieceType == 'knight') {
    isAllowed =
        couldMoveKnight(startingRow, startingColumn, targetRow, targetColumn);
  }

  if (incomingPieceType == 'king') {
    isAllowed =
        couldMoveKing(startingRow, startingColumn, targetRow, targetColumn);
  }
  if (incomingPieceType == 'queen') {
    isAllowed = couldMoveQueen(
        startingRow, startingColumn, targetRow, targetColumn, piecePositions);
  }
  if (incomingPieceType == 'rook') {
    isAllowed = couldMoveRook(
        startingRow, startingColumn, targetRow, targetColumn, piecePositions);
  }
  if (incomingPieceType == 'bishop') {
    isAllowed = couldMoveBishop(
        startingRow, startingColumn, targetRow, targetColumn, piecePositions);
  }
  if (incomingPieceType == 'pawn') {
    isAllowed = couldMovePawn(
        startingRow, startingColumn, targetRow, targetColumn, piecePositions);
  }
  print('Is allowed? ${isAllowed}');
  return isAllowed;
}

bool couldMovePawn(
    startingRow, startingColumn, targetRow, targetColumn, piecePositions) {
  var isAllowed = false;
  print('start');
  print(startingRow);
  print(startingColumn);
  print('target');
  print(targetRow);
  print(targetColumn);
  print(piecePositions[targetRow][targetColumn]);
  if (startingRow - 1 == targetRow &&
      startingColumn == targetColumn &&
      piecePositions[targetRow][targetColumn] == '') {
    isAllowed = true;
  }
  print(isAllowed);
  if ((startingColumn + 1 == targetColumn ||
          startingColumn - 1 == targetColumn) &&
      startingRow - 1 == targetRow &&
      piecePositions[targetRow][targetColumn] != '') {
    isAllowed = true;
  }

  if (startingRow == 6 &&
      startingColumn == targetColumn &&
      (startingRow - 2 == targetRow)) {
    isAllowed = true;
  }
  return isAllowed;
}

bool couldMoveDiagonally(
    startingRow, startingColumn, targetRow, targetColumn, piecePositions) {
  var isAllowed = false;
  if (targetRow - startingRow == targetColumn - startingColumn ||
      targetRow - startingRow == startingColumn - targetColumn) {
    var isPossible = true;
    var columnChange = 1;
    if (targetColumn < startingColumn) {
      columnChange = -1;
    }
    var rowChange = 1;
    if (targetRow < startingRow) {
      rowChange = -1;
    }
    var row = startingRow + rowChange;
    var column = startingColumn + columnChange;
    while (row != targetRow) {
      if (piecePositions[row][column] != '') {
        isPossible = false;
      }
      row += rowChange;
      column += columnChange;
    }
    isAllowed = isPossible;
  }
  return isAllowed;
}

bool couldMoveBishop(
    startingRow, startingColumn, targetRow, targetColumn, piecePositions) {
  return couldMoveDiagonally(
      startingRow, startingColumn, targetRow, targetColumn, piecePositions);
}

bool couldMoveLeftRightUpDown(
    startingRow, startingColumn, targetRow, targetColumn, piecePositions) {
  var isAllowed = false;
  var rowChange = 0;
  var columnChange = 0;
  if (startingRow != targetRow) {
    if (startingRow > targetRow)
      rowChange = -1;
    else
      rowChange = 1;
  }
  if (startingColumn != targetColumn) {
    if (startingColumn > targetColumn)
      columnChange = -1;
    else
      columnChange = 1;
  }
  var isPossible = true;
  var row = startingRow + rowChange;
  var column = startingColumn + columnChange;
  while (row != targetRow || column != targetColumn) {
    if (piecePositions[row][column] != '') {
      isPossible = false;
    }
    row += rowChange;
    column += columnChange;
  }
  isAllowed = isPossible;
  return isAllowed;
}

bool couldMoveRook(
    startingRow, startingColumn, targetRow, targetColumn, piecePositions) {
  return couldMoveLeftRightUpDown(
      startingRow, startingColumn, targetRow, targetColumn, piecePositions);
}

bool couldMoveQueen(
    startingRow, startingColumn, targetRow, targetColumn, piecePositions) {
  var isAllowed = false;
  if (startingColumn != targetColumn && startingRow != targetRow) {
    isAllowed = couldMoveDiagonally(
        startingRow, startingColumn, targetRow, targetColumn, piecePositions);
  } else {
    isAllowed = couldMoveLeftRightUpDown(
        startingRow, startingColumn, targetRow, targetColumn, piecePositions);
  }
  return isAllowed;
}

bool couldMoveKing(startingRow, startingColumn, targetRow, targetColumn) {
  if (startingRow + 1 == targetRow &&
          (startingColumn == targetColumn ||
              startingColumn + 1 == targetColumn ||
              startingColumn - 1 == targetColumn) ||
      startingRow - 1 == targetRow &&
          (startingColumn == targetColumn ||
              startingColumn + 1 == targetColumn ||
              startingColumn - 1 == targetColumn) ||
      startingRow == targetRow && startingColumn + 1 == targetColumn ||
      startingRow == targetRow && startingColumn - 1 == targetColumn) {
    // TODO: CHECK THAT KING IS NOT PERFORMING A SUICIDE!!!
    return true;
  }
  return false;
}

bool couldMoveKnight(startingRow, startingColumn, targetRow, targetColumn) {
  var isAllowed = false;
  final allowedPositions = [];
  allowedPositions.add([startingRow - 2, startingColumn - 1]);
  allowedPositions.add([startingRow - 2, startingColumn + 1]);
  allowedPositions.add([startingRow + 2, startingColumn - 1]);
  allowedPositions.add([startingRow + 2, startingColumn + 1]);
  allowedPositions.add([startingRow - 1, startingColumn - 2]);
  allowedPositions.add([startingRow - 1, startingColumn + 2]);
  allowedPositions.add([startingRow + 1, startingColumn - 2]);
  allowedPositions.add([startingRow + 1, startingColumn + 2]);
  allowedPositions.forEach((element) {
    if (element[0] == targetRow && element[1] == targetColumn) {
      isAllowed = true;
    }
  });
  return isAllowed;
}
