import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> nameAlreadyExists(String userName) async {
  final peopleCollection =
      await FirebaseFirestore.instance.collection('people').get();
  var nameExistsInDatabase = false;
  var peopleIterator = peopleCollection.docs.iterator;
  while (peopleIterator.moveNext()) {
    if (peopleIterator.current['name'] == userName) {
      nameExistsInDatabase = true;
    }
  }
  return nameExistsInDatabase;
}
