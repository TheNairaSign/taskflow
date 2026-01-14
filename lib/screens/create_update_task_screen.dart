import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/providers/task_provider.dart';

class CreateUpdateTaskScreen extends StatefulWidget {
  final Task? task;

  const CreateUpdateTaskScreen({super.key, this.task});

  @override
  State<CreateUpdateTaskScreen> createState() => _CreateUpdateTaskScreenState();
}

class _CreateUpdateTaskScreenState extends State<CreateUpdateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _isCompleted;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    _isCompleted = widget.task?.status == 'completed';
    _dueDate = widget.task != null
        ? DateTime.parse(widget.task!.dueDate)
        : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Back',
            style: GoogleFonts.inter(color: theme.colorScheme.primary),
          ),
        ),
        title: Text(
          'New Task',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _submit,
            child: Text(
              'Done',
              style: GoogleFonts.inter(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Task',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Organize your workflow and set goals.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(
                context,
                controller: _titleController,
                labelText: 'TASK TITLE',
                hintText: 'e.g., Q3 Design Review',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                context,
                controller: _descriptionController,
                labelText: 'DESCRIPTION',
                hintText: 'What needs to be done?',
                maxLines: 5,
              ),
              const SizedBox(height: 40),
              Text(
                'CONFIGURATION',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 20),
              _buildConfigurationTile(
                context,
                icon: EvaIcons.checkmarkCircle2Outline,
                title: 'Mark as Completed',
                subtitle: 'Start task as finished',
                trailing: Switch(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                  activeColor: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildConfigurationTile(
                context,
                icon: EvaIcons.calendarOutline,
                title: 'Due Date',
                subtitle: '${_dueDate.toLocal()}'.split(' ')[0],
                onTap: _selectDate,
                trailing: Icon(
                  EvaIcons.arrowIosForwardOutline,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Create Task',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                GoogleFonts.inter(color: theme.colorScheme.onSurface.withOpacity(0.4)),
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildConfigurationTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.onSurface),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.task?.id,
        userId: widget.task?.userId ?? 1, // Mock user ID
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _dueDate.toIso8601String(),
        project: widget.task?.project ?? 'New Project',
        priority: widget.task?.priority ?? 'Medium Priority',
        status: _isCompleted ? 'completed' : 'pending',
      );

      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      if (widget.task == null) {
        taskProvider.createTask(task);
      } else {
        taskProvider.updateTask(task);
      }
      Navigator.of(context).pop();
    }
  }
}
