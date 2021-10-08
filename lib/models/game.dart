import 'package:cloud_firestore/cloud_firestore.dart';

import '../gaming_stuff/situation_format_conversions.dart';
import '../gaming_stuff/get_fresh_game.dart';

class Game {
  final String me;
  final String id;
  final String black;
  final String blackLevel;
  final String white;
  final String whiteLevel;
  final String createdAt;
  final String next;
  final List<dynamic> players;
  final List<dynamic> situation;
  final List<dynamic> history;
  Game(
      {required this.me,
      required this.id,
      required this.black,
      required this.blackLevel,
      required this.white,
      required this.whiteLevel,
      required this.createdAt,
      required this.next,
      required this.history,
      required this.players,
      required this.situation});

  factory Game.fromFirestore(
      QueryDocumentSnapshot<Object?> documentSnapshot, String name) {
    // print(documentSnapshot['history'].runtimeType);

    var situationArray = convertToArray(documentSnapshot['situation']);

    if (situationArray.length == 0) {
      situationArray = getFreshGame();
    }

    return Game(
      me: name,
      id: documentSnapshot.id,
      black: documentSnapshot['black'],
      blackLevel: documentSnapshot['blackLevel'],
      white: documentSnapshot['white'],
      whiteLevel: documentSnapshot['whiteLevel'],
      createdAt: documentSnapshot['createdAt'],
      next: documentSnapshot['next'],
      history: convertToArray(documentSnapshot['history']),
      players: documentSnapshot['players'],
      situation: situationArray,
    );
  }
}
