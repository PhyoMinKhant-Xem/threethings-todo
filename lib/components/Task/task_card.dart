import 'package:flutter/material.dart';
import 'task_list_screen.dart'; // Import Task model

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Checkbox
            Checkbox(
              value: task.isDone,
              onChanged: (value) => onToggle(),
              activeColor: Colors.blue,
            ),
            SizedBox(width: 10),

            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),

            // 3 Dots Menu
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
