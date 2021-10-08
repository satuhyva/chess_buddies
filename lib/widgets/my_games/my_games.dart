import 'package:chess_buddies/models/game.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';
import '../../providers/game_provider.dart';
import '../../services/firebase/database_service.dart';

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

  Future<void> continuePlaying(Game game, setGameParameters) async {
    setGameParameters(game);
    Navigator.of(context).pushReplacementNamed(
      '/play',
    );
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
                return ListView.builder(
                  itemCount: gamesDocuments.length,
                  itemBuilder: (ctx, index) {
                    final document = gamesDocuments[index];
                    final game = Game.fromFirestore(document, myName);
                    final dotColor =
                        game.white == myName ? Colors.white : Colors.black;
                    final opponent =
                        game.white == myName ? game.black : game.white;
                    final opponentLevel = game.white == myName
                        ? game.blackLevel
                        : game.whiteLevel;
                    // TODO: inform user when it is his turn next!!!
                    // final nextTurnIsMine =
                    //     document['next'] == myName ? true : false;
                    return Card(
                      elevation: 6,
                      color: Theme.of(context).primaryColorLight,
                      // Return something other than listtile where there can be more data and buttons!!!
                      child: ListTile(
                        minVerticalPadding: 10,
                        leading: Icon(
                          Icons.circle,
                          size: 30,
                          color: dotColor,
                        ),
                        title: Text(
                            'OPPONENT: ${opponent.toString().toUpperCase()}\nLEVEL: ${opponentLevel.toString().toUpperCase()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text('Started: ${game.createdAt}',
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic))),
                        // TODO: add a button to delete game!
                        trailing: IconButton(
                            onPressed: () => continuePlaying(
                                game, gameProvider.setGameParameters),
                            icon: const Icon(
                              Icons.sports_esports,
                              size: 30,
                            )),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
