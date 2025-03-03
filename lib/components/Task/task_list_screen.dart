import 'package:flutter/material.dart';
import 'package:threethings/methods/database_methods/streak_method.dart';
import 'package:threethings/methods/database_methods/todo_method.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/objects/streak.dart';
import 'package:threethings/objects/todo.dart';
import 'package:threethings/utils/custom_response.dart';
import 'task_card.dart';

class TaskListScreen extends StatefulWidget {
  AppUser user;
  final bool showFAB; // Add a flag for FAB visibility

  TaskListScreen({this.showFAB = true, required this.user}); // Default to true

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  DateTime today = DateTime.now();
  List<Todo> _todos = [];
  List<Streak> _streaks = [];
  Streak? _todayStreak;

  @override
  void initState() {
    super.initState();
    _todos = widget.user.todoList;
    _streaks = widget.user.streakList;
    _todayStreak =   _streaks.firstWhere(
          (streak) =>
      streak.date?.year == today.year &&
          streak.date?.month == today.month &&
          streak.date?.day == today.day,
      orElse: () => Streak(
        id: (_streaks.length + 1).toString(),
        todoIds: [],
        userEmail: widget.user.email,
        numberOfTodosUserHasToday: widget.user.todoList.length,
        date: new DateTime.now(),
      ),
    );
    print(widget.user.todoList);
    print(widget.user.streakList);
  }

  void _toggleTaskStatus(int todoId) async {
    final result = await tweakStreak(widget.user, todoId);
    if (result.status == OperationStatus.success) {
      const statusSnackBar = SnackBar(content: Text("Ok!"));
      ScaffoldMessenger.of(context).showSnackBar(statusSnackBar);
    }
    //TODO: handle other responses as well.
    setState(() {});
  }

  void _deleteTask(int todoId) async {
    final result = await deleteTodo(todoId, widget.user);
    if (result.status == OperationStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${result.message}")),
      );
    }
    // TODO: handle other responses as well.
  }

  void _editTask(int taskId) {
    Todo? todo = _todos.firstWhere(
      (todo) => todo.todoId == taskId,
    );

    _showTaskDialog(
      title: 'Edit Task',
      initialTitle: todo.title,
      initialDescription: todo.description,
      onSave: (newTitle, newDescription) async {
        todo.title = newTitle;
        todo.description = newDescription;
        final result = await updateTodo(todo, widget.user);
        if (result.status == OperationStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${result.message}")),
          );
        }
        // TODO: handle other responses as well.
      },
    );
  }

  void _addTask() {
    _showTaskDialog(
      title: 'Add New Task',
      onSave: (newTitle, newDescription) async {
        print(newTitle + newDescription);
        if (widget.user.todoList.length < 3) {
          final newTodo = Todo(
              id: _todos.length + 1,
              title: newTitle,
              description: newDescription);

          final result = await createTodo(newTodo, widget.user);
          if (result.status == OperationStatus.success) {
            final successSnackBar =
                SnackBar(content: Text("${result.message}"));
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
          }
          //TODO: handle other responses as well.
        } else {
          const errorSnackBar =
              SnackBar(content: Text("Hey! We do only 3 things remember?"));
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        }
      },
    );
  }

  void _showTaskDialog({
    required String title,
    String initialTitle = '',
    String initialDescription = '',
    required Function(String, String) onSave,
  }) {
    String taskTitle = initialTitle;
    String taskDescription = initialDescription;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) => taskTitle = value,
                controller: TextEditingController(text: initialTitle),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) => taskDescription = value,
                controller: TextEditingController(text: initialDescription),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (taskTitle.trim().isNotEmpty) {
                        onSave(taskTitle, taskDescription);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return TaskCard(
                streak: _todayStreak,
                task: _todos[index],
                onToggle: () => _toggleTaskStatus(index),
                onDelete: () => _deleteTask(index),
                onEdit: () => _editTask(index),
              );
            },
          ),
        ),
        if (widget.showFAB) ...[
          // Show FAB only when showFAB is true
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _addTask,
            child: Icon(Icons.add),
          ),
        ],
      ],
    );
  }
}
