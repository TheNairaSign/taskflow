import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/screens/task_details_screen.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskProvider.error != null) {
          return Center(child: Text('Error: ${taskProvider.error}'));
        }

        if (taskProvider.tasks.isEmpty) {
          return const Center(child: Text('No tasks found.'));
        }

        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text('Task ID: ${task.id}'),
              trailing: Chip(
                label: Text(task.status == 'completed' ? 'Completed' : 'Pending'),
                backgroundColor: task.status == 'completeted'
                    ? Colors.green.withOpacity(0.2)
                    : Colors.orange.withOpacity(0.2),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailsScreen(task: task),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
