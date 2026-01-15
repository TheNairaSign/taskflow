import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/task_priority.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:another_flushbar/flushbar.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeFormat = DateFormat.jm();
    final startTime = task.startTime != null ? timeFormat.format(DateTime(2023, 1, 1, task.startTime!.hour, task.startTime!.minute)) : '';

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id!);
        Flushbar(
          title: "Task Deleted",
          message: "The task '${task.title}' has been deleted.",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.red,
          ),
          leftBarIndicatorColor: Colors.red,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          backgroundColor: Theme.of(context).colorScheme.surface,
          boxShadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
        ).show(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Checkbox(
            value: task.status == 'completed',
            shape: const CircleBorder(),
            onChanged: (value) {
              // TODO: Implement task status change
            },
          ),
          title: Row(
            children: [
              Text(task.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              const Spacer(),
              Text(startTime, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
            ],
          ),
          subtitle: Text(task.project, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
          // trailing: Chip(
          //   label: Text(task.priority.toString().split('.').last),
          //   backgroundColor: _getPriorityColor(task.priority, theme),
          // ),
        ),
      ),
    );
  }

  Color _getPriorityColor(TaskPriority priority, ThemeData theme) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red.withOpacity(0.2);
      case TaskPriority.strategic:
        return Colors.blue.withOpacity(0.2);
      default:
        return Colors.green.withOpacity(0.2);
    }
  }
}