import 'package:chess_buddies/models/game.dart';
import 'package:flutter/material.dart';

import './animated_dot.dart';

class MyGameCard extends StatelessWidget {
  final Game game;
  final String myName;
  Function setGameParameters;
  MyGameCard(
      {required this.game,
      required this.myName,
      required this.setGameParameters});

  Future<void> continuePlaying(
      Game game, setGameParameters, BuildContext context) async {
    setGameParameters(game);
    Navigator.of(context).pushReplacementNamed(
      '/play',
    );
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = game.white == myName ? Colors.white : Colors.black;
    final opponent = game.white == myName ? game.black : game.white;
    final opponentLevel =
        game.white == myName ? game.blackLevel : game.whiteLevel;
    final myColor = game.white == myName ? 'white' : 'black';
    final isMyTurnNext = game.next == myColor;
    return Card(
      elevation: 6,
      color: Theme.of(context).primaryColor,
      // Return something other than listtile where there can be more data and buttons!!!
      child: ListTile(
        minVerticalPadding: 10,
        leading: isMyTurnNext
            ? AnimatedDot(dotColor: dotColor)
            : Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: dotColor, borderRadius: BorderRadius.circular(25))),

        title: RichText(
          text: TextSpan(
            text: '${opponent.toString().toUpperCase()}\n',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: opponentLevel.toLowerCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13)),
            ],
          ),
        ),
        subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text('Started: ${game.createdAt}',
                style: const TextStyle(fontStyle: FontStyle.italic))),
        // TODO: add a button to delete game!
        trailing: IconButton(
            onPressed: () => continuePlaying(game, setGameParameters, context),
            icon: const Icon(Icons.play_arrow, size: 35, color: Colors.black)),
      ),
    );
  }
}
