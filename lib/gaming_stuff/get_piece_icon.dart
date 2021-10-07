import './chess_pieces.dart';

String getPieceIcon(pieceName) {
  final parts = pieceName.split(' ');
  if (parts.length != 2) return '';
  final color = parts[0];
  final piece = parts[1];
  return chessPieces[color]?[piece] ?? '';
}
