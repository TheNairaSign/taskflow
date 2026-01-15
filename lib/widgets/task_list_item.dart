import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/task_priority.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeFormat = DateFormat.jm();
    final startTime = task.startTime != null ? timeFormat.format(DateTime(2023, 1, 1, task.startTime!.hour, task.startTime!.minute)) : '';

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.status == 'completed',
          shape: CircleBorder(),
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
    );
  }

  Color _getPriorityColor(TaskPriority priority, ThemeData theme) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red.withValues(alpha: 0.2);
      case TaskPriority.strategic:
        return Colors.blue.withValues(alpha: 0.2);
      default:
        return Colors.green.withValues(alpha: 0.2);
    }
  }
}