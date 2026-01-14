class Task {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final String dueDate;
  final String project;
  final String priority;
  String status;

  Task({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.project,
    required this.priority,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'] ?? '',
      dueDate: json['dueDate'] ?? '',
      project: json['project'] ?? '',
      priority: json['priority'] ?? 'Medium Priority',
      status: json['completed'] == true ? 'completed' : 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'project': project,
      'priority': priority,
      'completed': status == 'completed',
    };
  }
}