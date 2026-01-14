import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/routes/app_page_route.dart';
import 'package:task_flow/screens/create_update_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowIosBackOutline),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Task Details',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.moreHorizontalOutline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(task.status).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(
                  task.status == 'completed' ? 24 : 12,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getStatusIcon(task.status),
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    task.status.toUpperCase().replaceAll('_', ' '),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              task.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Divider(color: isDark ? Colors.grey[700] : Colors.grey[300],),
            const SizedBox(height: 24),
            _buildDetailRow(
              context,
              icon: EvaIcons.hashOutline,
              title: 'Task ID',
              value: '#TF-${task.id}',
            ),
            const SizedBox(height: 20),
            _buildDetailRow(
              context,
              icon: EvaIcons.calendarOutline,
              title: 'Created Date',
              value: 'Oct 24, 2023', // Placeholder
            ),
            const SizedBox(height: 20),
            _buildDetailRow(
              context,
              icon: EvaIcons.personOutline,
              title: 'Assigned User',
              valueWidget: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=50&h=50&fit=crop'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Alex Rivera',
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  AppPageRoute(
                    builder: (context) => CreateUpdateTaskScreen(task: task),
                  ),
                );
              },
              icon: Icon(EvaIcons.edit2Outline,
                  color: theme.colorScheme.onSurface),
              label: Text(
                'Edit Task',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.surface,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context,
    {
      required IconData icon,
      required String title,
      String? value,
      Widget? valueWidget
    }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        const SizedBox(width: 16),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const Spacer(),
        if (value != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (valueWidget != null) valueWidget,
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return EvaIcons.clockOutline;
      case 'in_progress':
        return EvaIcons.syncOutline;
      case 'completed':
        return EvaIcons.checkmarkCircle2Outline;
      default:
        return EvaIcons.questionMarkCircleOutline;
    }
  }
}
