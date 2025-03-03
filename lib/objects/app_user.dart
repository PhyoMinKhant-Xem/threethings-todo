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

  String get getId => _uId;

  AppUser(this._uId,
      {required this.name,
      required this.email,
      this.profilePic = "",
      this.numbersOfTodosOwn = 0,
      this.streak = 0,
      required this.streakList,
      required this.todoList}) {
    assert(streak < 0, "Streak can't less than 0.");
    assert(numbersOfTodosOwn < 0 || numbersOfTodosOwn > 3,
        "Number of To Do can't be less than '3' or larger than '0'.");
  }

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

    return userMap;
  }

  static AppUser toObject(Map<String, dynamic> userMap) {
    var user = new AppUser(
      userMap['id'],
      name: userMap['name'],
      email: userMap['email'],
      profilePic: userMap['profilePic'],
      numbersOfTodosOwn: userMap['numberOfTodosOwn'],
      streak: userMap['streak'],
      streakList: (userMap['streakList'] as List<dynamic>)
          .map((streakMap) => Streak.toObject(streakMap))
          .toList(),
      todoList: (userMap['todoList'] as List<dynamic>)
          .map((streakMap) => Todo.toObject(streakMap))
          .toList(),
    );

    return user;
  }
}
