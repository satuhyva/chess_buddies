import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer/custom_drawer.dart';
import '../widgets/playing_game/game_board.dart';
import '../widgets/loading_spinner/loading_spinner.dart';
// import '../models/play_route_arguments.dart';
import '../gaming_stuff/situation_format_conversions.dart';
import '../../providers/game_provider.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final documentId = gameProvider.id;
    // final routeArguments =
    //     ModalRoute.of(context)!.settings.arguments as PlayRouteArguments;
    // final documentId = routeArguments.documentId;
    // final myName = routeArguments.myName;

    final Stream<DocumentSnapshot> game = FirebaseFirestore.instance
        .collection('games')
        .doc(documentId)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CHESS BUDDIES'),
        ),
        drawer: const CustomDrawer(),
        body: StreamBuilder(
          stream: game,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingSpinner(
                  backgroundColor: Colors.transparent,
                  ballColor: Theme.of(context).primaryColor);
            }

            final gamesData = snapshot.data;
            if (gamesData == null) return const Text('Something went wrong!');
            var situation = gamesData['situation'];
            if (situation.entries.length > 0) {
              situation = convertToArray(situation);
            }
            // TODO: talleta tässä tilanne Provideriin?
            return GameBoard();
          },
        ));
  }
}
