import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/screens/task_details_screen.dart';
import 'package:task_flow/routes/app_page_route.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:another_flushbar/flushbar.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = task.status == 'completed';
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (task.id != null) Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id!);
        Flushbar(
          titleText: Text("Task Deleted", style: Theme.of(context).textTheme.bodyMedium,),
          messageText: Text("The task '${task.title}' has been deleted.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),),
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
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
        ).show(context);
      },
      child: Opacity(
        opacity: isCompleted ? 0.6 : 1.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.grey
                          : (task.status == 'pending' ? Colors.orange : Colors.green),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ((task.status ?? 'pending').replaceAll('_', ' ').toUpperCase()),
                    style: GoogleFonts.inter(
                      color: isCompleted
                          ? Colors.grey
                          : (task.status == 'pending' ? Colors.orange : Colors.green),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                task.title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCompleted
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.6)
                      : theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: isCompleted
                      ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: isCompleted
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.6)
                            : theme.colorScheme.onSurface,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatDateWithTime(
                          task.scheduledDate ?? DateTime.now(),
                          task.startTime,
                        ),
                        style: GoogleFonts.inter(
                          color: isCompleted
                              ? theme.colorScheme.onSurface.withValues(alpha: 0.6)
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        AppPageRoute(
                          builder: (context) => TaskDetailsScreen(task: task),
                        ),
                      );
                    },
                    child: Text(
                      'Details',
                      style: GoogleFonts.inter(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDateWithTime(DateTime date, TimeOfDay? time) {
  final dateStr = DateFormat('EEE d, yyyy').format(date);
  if (time == null) return dateStr;
  final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
  final timeStr = DateFormat.jm().format(dt);
  return '$dateStr $timeStr';
}
