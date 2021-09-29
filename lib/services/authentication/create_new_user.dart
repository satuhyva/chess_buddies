import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createNewUser(
    String name, String email, String id, String level) async {
  DocumentReference ref =
      FirebaseFirestore.instance.collection('people').doc(id);
  await ref.set({'name': name, 'level': level});
}
