import 'package:flutter/material.dart';
import 'package:task_flow/models/task_priority.dart';

class Task {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final String project;
  String? status;

  // New fields
  final DateTime? scheduledDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? teamId;
  final TaskPriority priority;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Task({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.project,
    this.status,
    this.scheduledDate,
    this.startTime,
    this.endTime,
    this.teamId,
    this.priority = TaskPriority.normal,
    required this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'] ?? '',
      project: json['project'] ?? '',
      status: json['completed'] == true ? 'completed' : 'pending',
      scheduledDate: json['scheduledDate'] != null ? DateTime.parse(json['scheduledDate']) : null,
      startTime: json['startTime'] != null ? TimeOfDay(hour: int.parse(json['startTime'].split(':')[0]), minute: int.parse(json['startTime'].split(':')[1])) : null,
      endTime: json['endTime'] != null ? TimeOfDay(hour: int.parse(json['endTime'].split(':')[0]), minute: int.parse(json['endTime'].split(':')[1])) : null,
      teamId: json['teamId'],
      priority: _priorityFromString(json['priority']),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'project': project,
      'completed': status == 'completed',
      'scheduledDate': scheduledDate?.toIso8601String(),
      'startTime': startTime != null ? '${startTime!.hour}:${startTime!.minute}' : null,
      'endTime': endTime != null ? '${endTime!.hour}:${endTime!.minute}' : null,
      'teamId': teamId,
      'priority': priority.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static TaskPriority _priorityFromString(String? priority) {
    if (priority == null) {
      return TaskPriority.normal;
    }
    switch (priority.toLowerCase()) {
      case 'high priority':
      case 'high':
        return TaskPriority.high;
      case 'strategic':
        return TaskPriority.strategic;
      case 'medium priority':
      case 'normal':
      default:
        return TaskPriority.normal;
    }
  }
}
