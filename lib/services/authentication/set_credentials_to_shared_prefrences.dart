import 'package:shared_preferences/shared_preferences.dart';

void setCredentialsToSharedPreferences(
    String name, String level, String password, String email) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('NAME_IN_CHESSBUDDIES', name);
  preferences.setString('LEVEL_IN_CHESSBUDDIES', level);
  preferences.setString('PASSWORD_IN_CHESSBUDDIES', password);
  preferences.setString('EMAIL_IN_CHESSBUDDIES', email);
}
