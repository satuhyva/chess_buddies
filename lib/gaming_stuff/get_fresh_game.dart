final TOP_ROW_NAMES = [
  'rook',
  'knight',
  'bishop',
  'queen',
  'king',
  'bishop',
  'knight',
  'rook'
];
final PAWN_ROW_NAMES = [
  'pawn',
  'pawn',
  'pawn',
  'pawn',
  'pawn',
  'pawn',
  'pawn',
  'pawn'
];
final EMPTY_ROW = ['', '', '', '', '', '', '', ''];
final BOTTOM_ROW_NAMES = [
  'rook',
  'knight',
  'bishop',
  'king',
  'queen',
  'bishop',
  'knight',
  'rook'
];

getFreshGame() {
  var positions = [];

  final rowNames = [
    TOP_ROW_NAMES,
    PAWN_ROW_NAMES,
    EMPTY_ROW,
    EMPTY_ROW,
    EMPTY_ROW,
    EMPTY_ROW,
    PAWN_ROW_NAMES,
    BOTTOM_ROW_NAMES
  ];
  final colors = ['black', 'black', '', '', '', '', 'white', 'white'];
  for (var i = 0; i < 8; i++) {
    if (i > 1 && i < 6) {
      positions.add(EMPTY_ROW);
    } else {
      final currentNames = rowNames[i];
      final color = colors[i];
      var nextRow = [];
      for (var j = 0; j < 8; j++) {
        nextRow.add(color + ' ' + currentNames[j]);
      }
      positions.add(nextRow);
    }
  }
  return positions;
}
