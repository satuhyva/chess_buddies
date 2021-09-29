import 'package:flutter/material.dart';

import './drawer_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text('CONTENTS',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight))),
        const DrawerListTile(
          title: 'SETTINGS',
          iconData: Icons.settings,
          route: '/settings',
        ),
        const DrawerListTile(
          title: 'MANAGE MY PROPOSALS',
          iconData: Icons.apps,
          route: '/manage_my_proposals',
        ),
        const DrawerListTile(
          title: 'BROWSE PROPOSALS',
          iconData: Icons.sports_esports,
          route: '/browse_proposals',
        ),
        const DrawerListTile(
          title: 'MY GAMES',
          iconData: Icons.sports_esports,
          route: '/my_games',
        ),
        const DrawerListTile(
          title: 'PLAY',
          iconData: Icons.sports_esports,
          route: '/play',
        )
      ]),
    );
  }
}
