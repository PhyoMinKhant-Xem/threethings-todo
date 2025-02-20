import 'package:flutter/material.dart';
import 'task_card.dart';

class TaskListScreen extends StatefulWidget {
  final bool showFAB; // Add a flag for FAB visibility

  TaskListScreen({this.showFAB = true}); // Default to true

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [
    Task(
      title: 'Complete Flutter Project',
      description: 'Finish the daily streak feature and task manager UI.',
      isDone: false,
    ),
    Task(
      title: 'Buy Groceries',
      description: 'Milk, Eggs, Bread, and Vegetables.',
      isDone: true,
    ),
  ];

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index) {
    _showTaskDialog(
      title: 'Edit Task',
      initialTitle: _tasks[index].title,
      initialDescription: _tasks[index].description,
      onSave: (newTitle, newDescription) {
        setState(() {
          _tasks[index].title = newTitle;
          _tasks[index].description = newDescription;
        });
      },
    );
  }

  void _addTask() {
    _showTaskDialog(
      title: 'Add New Task',
      onSave: (newTitle, newDescription) {
        setState(() {
          _tasks.add(Task(
              title: newTitle, description: newDescription, isDone: false));
        });
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
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: _tasks[index],
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

class Task {
  String title;
  String description;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    this.isDone = false,
  });
}
