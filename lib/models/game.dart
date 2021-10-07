class Game {
  final String id;
  final String black;
  final String blackLevel;
  final String white;
  final String whiteLevel;
  final String createdAt;
  final String next;
  final List<dynamic> players;
  final Map<String, dynamic> situation;
  final Map<String, dynamic> history;
  Game(
      {required this.id,
      required this.black,
      required this.blackLevel,
      required this.white,
      required this.whiteLevel,
      required this.createdAt,
      required this.next,
      required this.history,
      required this.players,
      required this.situation});
}
