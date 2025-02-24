class User {
  String name;
  late String _email;
  String password;
  String profilePic;
  int numbersOfTodosOwn;
  int streak;

  String get getEmail => _email;

  User(
      {required String email, required this.name, required this.password, this.profilePic = "", this.numbersOfTodosOwn = 0, this.streak = 0}) {
    _email = email;
    assert(streak < 0, "Streak can't less than 0.");
    assert(numbersOfTodosOwn < 0 || numbersOfTodosOwn >
        3, "Number of To Do can't be less than '3' or larger than '0'.");
  }

  static Map<String, dynamic> toMap(User user) {
    var userMap = Map<String, dynamic>();
    userMap['name'] = user.name;
    userMap['email'] = user.getEmail;
    userMap['password'] = user.password;
    userMap['profilePic'] = user.profilePic;
    userMap['numbersOfTodosOwn'] = user.numbersOfTodosOwn;
    userMap['streak'] = user.streak;

    return userMap;
  }

  static User toObject(Map<String, dynamic> userMap) {
    var user = new User(email: userMap['email'],
        name: userMap['name'],
        password: userMap['password'],
        profilePic: userMap['profilePic'],
        numbersOfTodosOwn: userMap['numberOfTodosOwn'],
        streak: userMap['streak']
    );

    return user;
  }
}