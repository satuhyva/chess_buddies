import '../gaming_stuff/situation_format_conversions.dart';
import '../models/piece.dart';

getUpdatedSituation(Piece movingPiece, int targetRow, int targetColumn,
    bool iAmWhite, List<dynamic> situation) {
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
  situation[fromRow][fromColumn] = '';
  situation[toRow][toColumn] = movingPieceName;
  return [...situation];
}
