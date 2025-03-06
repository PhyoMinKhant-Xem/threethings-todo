import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threethings/objects/streak.dart';
import 'package:threethings/objects/todo.dart';

class AppUser {
  final String _uId;
  String name;
  String email;
  String profilePic;
  int numbersOfTodosOwn;
  int streak;
  List<Streak> streakList = [];
  List<Todo> todoList = [];
  DateTime? lastStreakDay;

  String get getId => _uId;

  AppUser(this._uId,
      {required this.name,
        required this.email,
        this.profilePic = "",
        this.numbersOfTodosOwn = 0,
        this.streak = 0,
        required this.streakList,
        required this.todoList,
        this.lastStreakDay});

  static Map<String, dynamic> toMap(AppUser user) {
    var userMap = Map<String, dynamic>();
    userMap['id'] = user.getId;
    userMap['name'] = user.name;
    userMap['email'] = user.email;
    userMap['profilePic'] = user.profilePic;
    userMap['numbersOfTodosOwn'] = user.numbersOfTodosOwn;
    userMap['streak'] = user.streak;
    userMap['streakList'] =
        user.streakList.map((streak) => Streak.toMap(streak)).toList();
    userMap['todoList'] =
        user.todoList.map((todo) => Todo.toMap(todo)).toList();

    if (user.lastStreakDay != null) {
      userMap['lastStreakDay'] = user.lastStreakDay;
    }

    return userMap;
  }

  static AppUser toObject(Map<String, dynamic> userMap) {
    return AppUser(
      userMap['id'],
      name: userMap['name'],
      email: userMap['email'],
      profilePic: userMap['profilePic'],
      numbersOfTodosOwn: userMap['numbersOfTodosOwn'],
      streak: userMap['streak'],
      streakList: (userMap['streakList'] as List<dynamic>)
          .map((streakMap) => Streak.toObject(streakMap))
          .toList(),
      todoList: (userMap['todoList'] as List<dynamic>)
          .map((todoMap) => Todo.toObject(todoMap))
          .toList(),
      lastStreakDay: userMap['lastStreakDay'] != null
          ? _parseLastStreakDay(userMap['lastStreakDay'])
          : null,
    );
  }

  static DateTime _parseLastStreakDay(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else {
      throw Exception("Unexpected type for lastStreakDay: ${value.runtimeType}");
    }
  }


  static AppUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return toObject(snapshot);
  }

  bool wasStreakYesterday() {
    if (lastStreakDay == null) return false;

    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return lastStreakDay!.year == yesterday.year &&
        lastStreakDay!.month == yesterday.month &&
        lastStreakDay!.day == yesterday.day;
  }
}
