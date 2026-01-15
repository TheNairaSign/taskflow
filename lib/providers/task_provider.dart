import 'package:flutter/material.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/task_priority.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  TaskProvider() {
    fetchTasks();
  }

  List<Task> tasksForDate(DateTime date) {
    return _tasks.where((task) {
      if (task.scheduledDate == null) {
        return false;
      }
      return task.scheduledDate!.year == date.year &&
          task.scheduledDate!.month == date.month &&
          task.scheduledDate!.day == date.day;
    }).toList();
  }

  List<Task> tasksForTeam(String teamId) {
    return _tasks.where((task) => task.teamId == teamId).toList();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Dummy data
    _tasks = [
      Task(
        id: 1,
        userId: 1,
        title: 'Design System Update',
        description: 'Update the mobile component library for the new branding.',
        project: 'Mobile App',
        priority: TaskPriority.high,
        status: 'pending',
        teamId: 'engineering',
        scheduledDate: DateTime.now().add(const Duration(days: 2)),
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 16, minute: 0),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 2,
        userId: 1,
        title: 'API Integration',
        description: 'Connect dashboard components to production API.',
        project: 'Web App',
        priority: TaskPriority.high,
        status: 'completed',
        teamId: 'engineering',
        scheduledDate: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 3,
        userId: 1,
        title: 'Weekly Sync Meeting',
        description: 'Internal team sync to discuss sprint progress and blockers.',
        project: 'General',
        priority: TaskPriority.normal,
        status: 'pending',
        teamId: 'product',
        scheduledDate: DateTime.now(),
        startTime: const TimeOfDay(hour: 10, minute: 30),
        endTime: const TimeOfDay(hour: 11, minute: 30),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 4,
        userId: 1,
        title: 'Finalize Project Proposal',
        description: 'Review and finalize the project proposal for the new client.',
        project: 'Marketing Campaign',
        priority: TaskPriority.high,
        status: 'in_progress',
        teamId: 'marketing',
        scheduledDate: DateTime.now().add(const Duration(days: 1)),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 5,
        userId: 1,
        title: 'Update API Documentation',
        description: 'Update the API documentation with the latest changes.',
        project: 'Backend Sync',
        priority: TaskPriority.normal,
        status: 'in_progress',
        teamId: 'engineering',
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 6,
        userId: 1,
        title: 'Team Sync Preparation',
        description: 'Prepare for the upcoming team sync meeting.',
        project: 'Internal Ops',
        priority: TaskPriority.normal,
        status: 'pending',
        teamId: 'product',
        scheduledDate: DateTime.now(),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 9, minute: 30),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 7,
        userId: 1,
        title: 'Client Interview Prep',
        description: 'Prepare for the client interview.',
        project: 'Research',
        priority: TaskPriority.high,
        status: 'completed',
        scheduledDate: DateTime.now().add(const Duration(days: 3)),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 8,
        userId: 1,
        title: 'Morning Standup',
        description: 'Daily standup.',
        project: 'General',
        priority: TaskPriority.normal,
        status: 'pending',
        teamId: 'engineering',
        scheduledDate: DateTime.now(),
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 8, minute: 30),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 9,
        userId: 1,
        title: 'Project Deep Dive',
        description: 'Deep dive into project requirements.',
        project: 'Mobile App',
        priority: TaskPriority.high,
        status: 'pending',
        teamId: 'product',
        scheduledDate: DateTime.now(),
        startTime: const TimeOfDay(hour: 10, minute: 30),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
      Task(
        id: 10,
        userId: 1,
        title: 'Client Presentation',
        description: 'Presentation for the client.',
        project: 'Marketing Campaign',
        priority: TaskPriority.strategic,
        status: 'pending',
        teamId: 'marketing',
        scheduledDate: DateTime.now(),
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 15, minute: 30),
        createdAt: DateTime.now(),
        updatedAt: null,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createTask(Task task) async {
    _tasks.insert(0, task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }
}
