import '../gaming_stuff/situation_format_conversions.dart';
import '../models/piece.dart';

getHistoryAddition(
    Piece movingPiece, int targetRow, int targetColumn, bool iAmWhite) {
  final movingPieceName = movingPiece.pieceName;

  final fromRow = iAmWhite
      ? movingPiece.row
      : convertRowOrColumnToTheOtherView(movingPiece.row);
  final fromColumn = iAmWhite
      ? movingPiece.column
      : convertRowOrColumnToTheOtherView(movingPiece.column);
  final toRow =
      iAmWhite ? targetRow : convertRowOrColumnToTheOtherView(targetRow);
  final toColumn =
      iAmWhite ? targetColumn : convertRowOrColumnToTheOtherView(targetColumn);
  final fromSquare = {
    'row': fromRow,
    'column': fromColumn,
  };
  final toSquare = {
    'row': toRow,
    'column': toColumn,
  };
  return {'pieceName': movingPieceName, 'from': fromSquare, 'to': toSquare};
}
