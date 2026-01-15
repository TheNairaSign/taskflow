import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/task_priority.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/providers/team_provider.dart';

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
  late DateTime _scheduledDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedTeamId;
  TaskPriority _priority = TaskPriority.normal;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    _isCompleted = widget.task?.status == 'completed';
    _scheduledDate = widget.task?.scheduledDate ?? DateTime.now();
    _startTime = widget.task?.startTime;
    _endTime = widget.task?.endTime;
    _selectedTeamId = widget.task?.teamId;
    _priority = widget.task?.priority ?? TaskPriority.normal;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUpdate = widget.task != null;
    final teamProvider = Provider.of<TeamProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowIosBackOutline),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isUpdate ? 'Update Task' : 'New Task',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.red,),
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
                isUpdate ? 'Update Task' : 'New Task',
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
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                title: 'Date',
                subtitle: '${_scheduledDate.toLocal()}'.split(' ')[0],
                onTap: _selectDate,
                trailing: Icon(
                  EvaIcons.arrowIosForwardOutline,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              _buildConfigurationTile(
                context,
                icon: EvaIcons.clockOutline,
                title: 'Start Time',
                subtitle: _startTime?.format(context) ?? 'Not set',
                onTap: () => _selectTime(isStart: true),
                trailing: Icon(
                  EvaIcons.arrowIosForwardOutline,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              _buildConfigurationTile(
                context,
                icon: EvaIcons.clockOutline,
                title: 'End Time',
                subtitle: _endTime?.format(context) ?? 'Not set',
                onTap: () => _selectTime(isStart: false),
                trailing: Icon(
                  EvaIcons.arrowIosForwardOutline,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedTeamId,
                hint: const Text('Assign to a team'),
                onChanged: (value) {
                  setState(() {
                    _selectedTeamId = value;
                  });
                },
                items: teamProvider.teams.map((team) {
                  return DropdownMenuItem(
                    value: team.id,
                    child: Text(team.name),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Team',
                  floatingLabelStyle: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .3),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),  
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Priority',
                  floatingLabelStyle: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .3),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),  
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: .3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isUpdate ? Colors.green :  theme.colorScheme.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isSubmitting
                    ? SizedBox(
                        key: const ValueKey('submit_loading'),
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : Text(
                        isUpdate ? 'Update Task' : 'Create Task',
                        key: const ValueKey('submit_text'),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isUpdate ? Colors.white : theme.colorScheme.onPrimary,
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
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                GoogleFonts.inter(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
            filled: true,
            fillColor: theme.colorScheme.surface,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: .3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),  
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: .3),
                width: 1,
              ),
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
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
      initialDate: _scheduledDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _scheduledDate) {
      setState(() {
        _scheduledDate = picked;
      });
    }
  }

  Future<void> _selectTime({required bool isStart}) async {
    final initialTime = isStart ? _startTime : _endTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _submit() {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }
    setState(() {
      _isSubmitting = true;
    });
    final task = Task(
      id: widget.task?.id,
      userId: widget.task?.userId ?? 1, // Mock user ID
      title: _titleController.text,
      description: _descriptionController.text,
      project: widget.task?.project ?? 'New Project',
      status: _isCompleted ? 'completed' : 'pending',
      scheduledDate: _scheduledDate,
      startTime: _startTime,
      endTime: _endTime,
      teamId: _selectedTeamId,
      priority: _priority,
      createdAt: widget.task?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    if (widget.task == null) {
      taskProvider.createTask(task);
    } else {
      taskProvider.updateTask(task);
    }
    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
      Navigator.of(context).pop();
    }
  }
}
