import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';
import '../../gaming_stuff/get_fresh_game.dart';
import '../../gaming_stuff/situation_format_conversions.dart';
import './square.dart';

class GameBoard extends StatelessWidget {
  // Future<void> initializeFreshGame() async {
  //   final startSituation = getFreshGame();
  //   final situationAsDictionary = convertToDictionary(startSituation);
  //   CollectionReference gamesReference =
  //       FirebaseFirestore.instance.collection('games');
  //   try {
  //     await gamesReference
  //         .doc(widget.gameId)
  //         .update({'situation': situationAsDictionary});
  //   } catch (error) {
  //     print(error);
  //   }

  getSquares() {
    List<Widget> squaresList = [];
    for (var rowIndex = 0; rowIndex < 8; rowIndex++) {
      List<Widget> row = [];
      for (var columnIndex = 0; columnIndex < 8; columnIndex++) {
        row.add(Square(row: rowIndex, column: columnIndex));
      }
      squaresList.add(Row(children: row));
    }
    return Column(
      children: squaresList,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('FROM FIRESTORE');
    // print(widget.next);
    // print(widget.white);
    // print(widget.black);
    // print(widget.iAmWhite);
    // print(widget.situation);
    // print(widget.history);
    // print('***************');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [getSquares()],
    );
  }
}
