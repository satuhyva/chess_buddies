import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../common/general_title.dart';
import '../loading_spinner/loading_spinner.dart';
// import '../../models/play_route_arguments.dart';
import '../../providers/game_provider.dart';
import '../../models/game.dart';

class MyGames extends StatefulWidget {
  @override
  _MyGamesState createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  var myName;

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

  Future<void> continuePlaying(document, setGameParameters) async {
    final game = Game(
      id: document.id,
      black: document['black'],
      blackLevel: document['blackLevel'],
      white: document['white'],
      whiteLevel: document['whiteLevel'],
      createdAt: document['createdAt'],
      situation: document['situation'],
      history: document['history'],
      players: document['players'],
      next: document['next'],
    );
    setGameParameters(game, myName);

    Navigator.of(context).pushReplacementNamed(
      '/play',
      // arguments: PlayRouteArguments(documentId, myName)
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    // Haetaan vain kerran tässä omat pelit, ettei tule joka tilannepäivityksestä uutta buildiä...
    CollectionReference myCurrentGamesReference =
        FirebaseFirestore.instance.collection('games');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralTitle(
          title_text: 'MY GAMES',
        ),
        Expanded(
          child: FutureBuilder(
              future: myCurrentGamesReference.get(),
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
                    final dotColor = document['white'] == myName
                        ? Colors.white
                        : Colors.black;
                    final opponent = document['white'] == myName
                        ? document['black']
                        : document['white'];
                    final opponentLevel = document['white'] == myName
                        ? document['blackLevel']
                        : document['whiteLevel'];
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
                            child: Text('Started: ${document['createdAt']}',
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic))),
                        // TODO: add a button to delete game!
                        trailing: IconButton(
                            onPressed: () => continuePlaying(
                                document, gameProvider.setGameParameters),
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
