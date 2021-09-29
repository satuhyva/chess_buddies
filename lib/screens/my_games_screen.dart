import 'package:flutter/material.dart';

import '../widgets/drawer/custom_drawer.dart';

class MyGamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CHESS BUDDIES'),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [const Text("GamesScreen")],
        ));
  }
}
