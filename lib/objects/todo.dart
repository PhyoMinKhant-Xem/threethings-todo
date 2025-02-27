class Todo {
  late int _id;
  String title;
  String description;

  int get todoId => _id;

  Todo({required int id, required this.title, this.description = ''}) {
    _id = id;
  }

  static Map<String, dynamic> toMap(Todo td) {
    var todoMap = Map<String, dynamic>();
    todoMap['id'] = td.todoId;
    todoMap['title'] = td.title;
    todoMap['description'] = td.description;

    return todoMap;
  }

  static Todo toObject(Map<String, dynamic> todoMap) {
    var todo = new Todo(
      id: todoMap['id'],
      title: todoMap['title'],
    );

    return todo;
  }
}
