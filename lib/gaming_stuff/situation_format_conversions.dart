convertToDictionary(someArray) {
  var asDictionary = {};
  for (var i = 0; i < someArray.length; i++) {
    asDictionary[i.toString()] = someArray[i];
  }
  return asDictionary;
}

convertToArray(someDictionary) {
  var asArray = [];
  someDictionary.forEach((key, value) => asArray.add(value));
  return asArray;
}

convertArrayToBlackView(List<dynamic> someArray) {
  var blackView = [];
  for (var i = 7; i >= 0; i--) {
    var row = [];
    for (var j = 7; j >= 0; j--) {
      row.add(someArray[i][j]);
    }
    blackView.add(row);
  }
  return blackView;
}

convertSquareToTheOtherView(row, column) {
  return [7 - row, 7 - column];
}

convertRowOrColumnToTheOtherView(rowOrColumn) {
  return 7 - rowOrColumn;
}
