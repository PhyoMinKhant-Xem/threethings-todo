class Streak {
  late String _id;
  DateTime? date;
  List<String> todoIds;
  String userEmail;
  int numberOfTodosUserHasToday;

  String get streakId => _id;

  Streak(
      {required String id,
      this.date,
      required this.todoIds,
      required this.userEmail,
      required this.numberOfTodosUserHasToday}) {
    date ??= DateTime.now();
    assert(userEmail.length == 0, "User Email can't be empty!");
  }

  static Map<String, dynamic> toMap(Streak s) {
    var streakMap = Map<String, dynamic>();
    streakMap['id'] = s.streakId;
    streakMap['date'] = s.date;
    streakMap['todoIds'] = s.todoIds;
    streakMap['userEmail'] = s.userEmail;
    streakMap['numberOfTodosUserHasToday'] = s.numberOfTodosUserHasToday;

    return streakMap;
  }

  static Streak toObject(Map<String, dynamic> streakMap) {
    var streak = new Streak(
        id: streakMap['id'],
        todoIds: streakMap['todoIds'],
        userEmail: streakMap['userEmail'],
        numberOfTodosUserHasToday: streakMap['numberOfTodosUserHasToday']);

    return streak;
  }
}
