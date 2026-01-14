import 'package:flutter/material.dart';
import 'package:task_flow/models/task.dart';

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
        dueDate: 'Oct 24, 2023',
        project: 'Mobile App',
        priority: 'High Priority',
        status: 'pending',
      ),
      Task(
        id: 2,
        userId: 1,
        title: 'API Integration',
        description: 'Connect dashboard components to production API.',
        dueDate: 'Oct 20, 2023',
        project: 'Web App',
        priority: 'High Priority',
        status: 'completed',
      ),
      Task(
        id: 3,
        userId: 1,
        title: 'Weekly Sync Meeting',
        description: 'Internal team sync to discuss sprint progress and blockers.',
        dueDate: 'Oct 26, 2023',
        project: 'General',
        priority: 'Medium Priority',
        status: 'pending',
      ),
      Task(
        id: 4,
        userId: 1,
        title: 'Finalize Project Proposal',
        description: 'Review and finalize the project proposal for the new client.',
        dueDate: 'Oct 25, 10:00 AM',
        project: 'Marketing Campaign',
        priority: 'High Priority',
        status: 'in_progress',
      ),
      Task(
        id: 5,
        userId: 1,
        title: 'Update API Documentation',
        description: 'Update the API documentation with the latest changes.',
        dueDate: 'Oct 26, 2:00 PM',
        project: 'Backend Sync',
        priority: 'Medium Priority',
        status: 'in_progress',
      ),
      Task(
        id: 6,
        userId: 1,
        title: 'Team Sync Preparation',
        description: 'Prepare for the upcoming team sync meeting.',
        dueDate: 'Oct 28, 9:00 AM',
        project: 'Internal Ops',
        priority: 'Low Priority',
        status: 'pending',
      ),
      Task(
        id: 7,
        userId: 1,
        title: 'Client Interview Prep',
        description: 'Prepare for the client interview.',
        dueDate: 'Oct 28, 2:00 PM',
        project: 'Research',
        priority: 'High Priority',
        status: 'completed',
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