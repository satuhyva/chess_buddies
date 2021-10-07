import 'package:flutter/material.dart';

import '../models/game.dart';
import '../gaming_stuff/situation_format_conversions.dart';

class GameProvider with ChangeNotifier {
  String gameId = '';
  String myName = '';
  String opponentName = '';
  List<dynamic> gameSituation = [];
  String nextTurn = '';
  List<dynamic> gameHistory = [];
  bool iAmWhite = false;

  void setGameParameters(Game game, String me) {
    gameId = game.id;
    myName = me;
    iAmWhite = game.white == me;
    opponentName = game.white == me ? game.black : game.white;
    //gameHistory = game.history;

    gameSituation = convertToArray(game.situation);
    nextTurn = game.next;
    // notifyListeners();
  }

  get id {
    return gameId;
  }

  get situation {
    return [...gameSituation];
  }

  get next {
    if (nextTurn == '') return '';
    if (nextTurn == 'white') return 'white';
    return 'black';
  }

  void changeGameStatus() {
    notifyListeners();
  }
}
