convertToDictionary(situationArray) {
  var asDictionary = {};
  for (var i = 0; i < 8; i++) {
    asDictionary[i.toString()] = situationArray[i];
  }
  return asDictionary;
}

convertToArray(situationDictionary) {
  var asArray = [];
  situationDictionary.forEach((key, value) => asArray.add(value));
  return asArray;
}
