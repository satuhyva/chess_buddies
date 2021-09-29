import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

Future<String> submitProposalToFirestore(
  String proposerColor,
  bool beginner,
  bool intermediate,
  bool advanced,
  bool champion,
) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.containsKey('NAME_IN_CHESSBUDDIES') &&
      preferences.containsKey('LEVEL_IN_CHESSBUDDIES')) {
    final proposedBy = preferences.getString('NAME_IN_CHESSBUDDIES');
    final proposerLevel = preferences.getString('LEVEL_IN_CHESSBUDDIES');

    try {
      final timeNow = DateFormat.yMMMd().format(DateTime.now());
      final response =
          await FirebaseFirestore.instance.collection('proposals').add({
        'proposerColor': proposerColor,
        'proposedBy': proposedBy,
        'proposerLevel': proposerLevel,
        'beginner': beginner,
        'intermediate': intermediate,
        'advanced': advanced,
        'champion': champion,
        'createdAt': timeNow,
      });
      return response.id;
    } catch (error) {
      return '';
    }
  }
  return '';
}
