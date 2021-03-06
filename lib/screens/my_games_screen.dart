import 'package:flutter/material.dart';

import '../widgets/drawer/custom_drawer.dart';
import '../widgets/my_games/my_games.dart';

class MyGamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CHESS BUDDIES'),
      ),
      drawer: CustomDrawer(),
      body: MyGames(),
    );
  }
}
