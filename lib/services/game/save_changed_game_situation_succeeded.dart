import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../widgets/authentication/get_snackbar.dart';

Future<void> saveChangedGameSituationSucceeded(
  BuildContext context,
  Map<dynamic, dynamic> situation,
  Map<dynamic, dynamic> history,
  String documentId,
  String next,
) async {
  await Firebase.initializeApp();
  CollectionReference games = FirebaseFirestore.instance.collection('games');
  try {
    await games.doc(documentId).set(
      {'history': history, 'situation': situation, 'next': next},
      SetOptions(merge: true),
    );
  } catch (error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(getSnackbar(context, 'SaveGameSituationFailed'));
  }
}
