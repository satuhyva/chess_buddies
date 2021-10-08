import 'package:flutter/material.dart';

import '../widgets/drawer/custom_drawer.dart';
import '../widgets/playing_game/game_board.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CHESS BUDDIES'),
      ),
      drawer: const CustomDrawer(),
      body: GameBoard(),
    );
  }
}
