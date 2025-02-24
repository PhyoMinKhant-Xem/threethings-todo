class Todo {
  late String _id;
  String title;
  String description;
  String userEmail;

  String get todoId => _id;

  Todo(
      {required String id,
      required this.title,
      this.description = '',
      required this.userEmail}) {
    _id = id;
    assert(userEmail.length == 0, "Email can't be empty!");
  }

  static Map<String, dynamic> toMap(Todo td) {
    var todoMap = Map<String, dynamic>();
    todoMap['id'] = td.todoId;
    todoMap['title'] = td.title;
    todoMap['description'] = td.description;
    todoMap['userEmail'] = td.userEmail;

    return todoMap;
  }

  static Todo toObject(Map<String, dynamic> todoMap) {
    var todo = new Todo(
        id: todoMap['id'],
        title: todoMap['title'],
        userEmail: todoMap['userEmail']);

    return todo;
  }
}
