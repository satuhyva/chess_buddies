import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/authentication_screen.dart';
import './screens/settings_screen.dart';
import './screens/play_screen.dart';
import './screens/manage_my_proposals_screen.dart';
import './screens/my_games_screen.dart';
import './screens/browse_proposals_screen.dart';
import './providers/game_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => GameProvider(),
        child: MaterialApp(
          title: 'CHESS BUDDIES',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            errorColor: const Color(0xFF9E0B00),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.blueGrey.shade900,
                primary: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          home: AuthenticationScreen(),
          routes: {
            '/settings': (ctx) => SettingsScreen(),
            '/my_games': (ctx) => MyGamesScreen(),
            '/play': (ctx) => PlayScreen(),
            '/manage_my_proposals': (ctx) => ManageMyProposalsScreen(),
            '/browse_proposals': (ctx) => BrowseProposalsScreen(),
          },
        ));
  }
}
