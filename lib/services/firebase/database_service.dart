import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

// import '../../models/proposal.dart';
// import '../../models/game.dart';

class DatabaseService {
  final database = FirebaseFirestore.instance;

  // Stream<List<Proposal>> proposalsByPerson(String personName) {
  //   var proposalsReference = database
  //       .collection('proposals')
  //       .where('proposedBy', isEqualTo: personName);
  //   return proposalsReference.snapshots().map((proposalsList) => proposalsList
  //       .docs
  //       .map((documentSnapshot) => Proposal.fromFirestore(documentSnapshot))
  //       .toList());
  // }

  Future<QuerySnapshot<Object?>> myGames() {
    CollectionReference myCurrentGamesReference = database.collection('games');
    return myCurrentGamesReference.get();
  }
}
