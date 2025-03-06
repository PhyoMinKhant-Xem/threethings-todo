import 'package:flutter/material.dart';
import 'package:threethings/methods/database_methods/streak_method.dart';
import 'package:threethings/methods/database_methods/todo_method.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/objects/streak.dart';
import 'package:threethings/objects/todo.dart';
import 'package:threethings/utils/custom_response.dart';
import 'task_card.dart';

class TaskListScreen extends StatelessWidget {
  final AppUser user;
  final bool showFAB;

  TaskListScreen({this.showFAB = true, required this.user});

  void _toggleTaskStatus(BuildContext context, int todoId) async {
    final result = await tweakStreak(user, todoId);
    if (result.status == OperationStatus.success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Ok!")));
    }
  }

  void _deleteTask(BuildContext context, int todoId) async {
    final result = await deleteTodo(todoId, user);
    if (result.status == OperationStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${result.message}")),
      );
    }
  }

  void _editTask(BuildContext context, int taskId) {
    Todo? todo = user.todoList.firstWhere((todo) => todo.todoId == taskId);

    _showTaskDialog(
      context: context,
      title: 'Edit Task',
      initialTitle: todo.title,
      initialDescription: todo.description,
      onSave: (newTitle, newDescription) async {
        todo.title = newTitle;
        todo.description = newDescription;
        final result = await updateTodo(todo, user);
        if (result.status == OperationStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${result.message}")),
          );
        }
      },
    );
  }

  void _addTask(BuildContext context) {
    _showTaskDialog(
      context: context,
      title: 'Add New Task',
      onSave: (newTitle, newDescription) async {
        if (user.todoList.length < 3) {
          // Generate a new unique ID based on the current max ID
          int newId = user.todoList.isEmpty
              ? 1
              : user.todoList.map((todo) => todo.todoId).reduce((a, b) => a > b ? a : b) + 1;

          final newTodo = Todo(
              id: newId,
              title: newTitle,
              description: newDescription);

          final result = await createTodo(newTodo, user);
          if (result.status == OperationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${result.message}")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hey! We do only 3 things, remember?")),
          );
        }
      },
    );
  }


  void _showTaskDialog({
    required BuildContext context,
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
    print(
        "DEBUG: Rebuilding TaskListScreen with ${user.todoList.length} tasks");

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: user.todoList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                streak: user.streakList.isNotEmpty ? user.streakList[0] : null,
                task: user.todoList[index],
                onToggle: () =>
                    _toggleTaskStatus(context, user.todoList[index].todoId),
                onDelete: () =>
                    _deleteTask(context, user.todoList[index].todoId),
                onEdit: () => _editTask(context, user.todoList[index].todoId),
              );
            },
          ),
        ),
        if (showFAB) ...[
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _addTask(context),
            child: Icon(Icons.add),
          ),
        ],
      ],
    );
  }
}
