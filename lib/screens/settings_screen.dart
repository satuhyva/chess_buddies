import 'package:flutter/material.dart';

import '../widgets/drawer/custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CHESS BUDDIES'),
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [],
        ));
  }
}
