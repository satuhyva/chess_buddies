import 'package:flutter/material.dart';

import '../models/game.dart';
import '../gaming_stuff/situation_format_conversions.dart';
import '../models/piece.dart';
import '../gaming_stuff/get_history_addition.dart';
import '../gaming_stuff/get_updated_situation.dart';
import '../services/game/save_changed_game_situation_succeeded.dart';

class GameProvider with ChangeNotifier {
  String _gameId = '';
  String _myName = '';
  String _opponentName = '';
  List<dynamic> _gameSituation = [];
  bool _nextIsMyTurn = false;
  List<dynamic> _gameHistory = [];
  bool _iAmWhite = false;
  bool _submitting = false;

  void setGameParameters(Game game) {
    _gameId = game.id;
    _myName = game.me;
    _iAmWhite = game.white == game.me;
    _opponentName = game.white == game.me ? game.black : game.white;
    _gameSituation = game.situation;
    _nextIsMyTurn =
        game.next == 'white' && _iAmWhite || game.next == 'black' && !_iAmWhite;
    _submitting = false;
  }

  get isMyTurn {
    return _nextIsMyTurn;
  }

  get situation {
    if (_iAmWhite) {
      return [..._gameSituation];
    }
    return convertArrayToBlackView([..._gameSituation]);
  }

  get situationWhiteView {
    return [..._gameSituation];
  }

  get iAmWhite {
    return _iAmWhite;
  }

  get id {
    return _gameId;
  }

  get history {
    return _gameHistory;
  }

  Future<void> makeAMove(Piece movingPiece, int targetRow, int targetColumn,
      BuildContext context) async {
    _submitting = true;
    _gameHistory.add(
        getHistoryAddition(movingPiece, targetRow, targetColumn, _iAmWhite));
    _gameSituation = getUpdatedSituation(
        movingPiece, targetRow, targetColumn, _iAmWhite, _gameSituation);
    final updatedSituation = convertToDictionary([..._gameSituation]);
    final updatedHistory = convertToDictionary([..._gameHistory]);
    final updatedNext = _iAmWhite ? 'black' : 'white';
    print(updatedHistory);
    print(updatedSituation);
    notifyListeners();

    await saveChangedGameSituationSucceeded(
      context,
      updatedSituation,
      updatedHistory,
      _gameId,
      updatedNext,
    );
    _submitting = false;
    _nextIsMyTurn = false;
    notifyListeners();
  }
}
