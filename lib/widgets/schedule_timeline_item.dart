import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/providers/task_provider.dart';

class ScheduleTimelineItem extends StatelessWidget {
  final Task task;

  const ScheduleTimelineItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final timeFormat = DateFormat.jm();
    final startTime = task.startTime != null ? timeFormat.format(DateTime(2023, 1, 1, task.startTime!.hour, task.startTime!.minute)) : '';
    final endTime = task.endTime != null ? timeFormat.format(DateTime(2023, 1, 1, task.endTime!.hour, task.endTime!.minute)) : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const SizedBox(width: 10),
            Column(
              children: [
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.grey.withValues(alpha: .3),
                ),
                
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.grey.withValues(alpha: .3),
                ),
                Text(startTime, style: theme.textTheme.bodySmall,),
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.withValues(alpha: .3),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [ BoxShadow(
                    color: isDark ? Colors.transparent : Colors.grey.withValues(alpha: .3),
                    blurRadius: 4.0,
                    offset: const Offset(-2, 5),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Checkbox(
                          value: task.status == 'completed',
                          onChanged: (val) {
                            final provider = Provider.of<TaskProvider>(context, listen: false);
                            final updated = Task(
                              id: task.id,
                              userId: task.userId,
                              title: task.title,
                              description: task.description,
                              project: task.project,
                              priority: task.priority,
                              scheduledDate: task.scheduledDate,
                              startTime: task.startTime,
                              endTime: task.endTime,
                              teamId: task.teamId,
                              status: (val ?? false) ? 'completed' : 'pending',
                              createdAt: task.createdAt,
                              updatedAt: DateTime.now(),
                            );
                            provider.updateTask(updated);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text('$startTime - $endTime', style: theme.textTheme.bodyMedium,),
                    const SizedBox(height: 8.0),
                    // Chip(
                    //   label: Text(task.priority.toString().split('.').last.toUpperCase()),
                    // ),
                    Row(
                      children: [
                        ...List.generate(3, (index) {
                          return CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.grey.withValues(alpha: .2),
                            backgroundImage: NetworkImage(imgList[index]),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final imgList = [
  'https://i.pravatar.cc/150?u=alice',
  'https://i.pravatar.cc/150?u=bob',
  'https://i.pravatar.cc/150?u=charlie',
];
