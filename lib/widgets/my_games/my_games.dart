import 'package:chess_buddies/models/game.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';
import '../../providers/game_provider.dart';
import '../../services/firebase/database_service.dart';
import './my_game_card.dart';

class MyGames extends StatefulWidget {
  @override
  _MyGamesState createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  var myName;
  final databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    initializeName();
  }

  Future<void> initializeName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('NAME_IN_CHESSBUDDIES')) {
      setState(() {
        myName = preferences.getString('NAME_IN_CHESSBUDDIES');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralTitle(
          title_text: 'MY GAMES',
        ),
        Text('Below is a list or your ongoing games.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('Dot color shows the color you play.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('It blinks if it is your turn now.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('Shown are also the name and the skill level of',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text('the opponent and the date the game was started.',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Expanded(
          child: FutureBuilder(
              future: databaseService.myGames(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingSpinner(
                      backgroundColor: Colors.transparent,
                      ballColor: Theme.of(context).primaryColor);
                }

                final gamesDocuments = snapshot.data!.docs;
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: gamesDocuments.length,
                    itemBuilder: (ctx, index) {
                      final document = gamesDocuments[index];
                      final game = Game.fromFirestore(document, myName);
                      // TODO: inform user when it is his turn next!!!
                      // final nextTurnIsMine =
                      //     document['next'] == myName ? true : false;
                      return MyGameCard(
                          game: game,
                          myName: myName,
                          setGameParameters: gameProvider.setGameParameters);
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
