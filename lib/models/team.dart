import 'package:task_flow/models/user.dart';

class Team {
  final String id;
  final String name;
  final List<User> members;

  Team({
    required this.id,
    required this.name,
    required this.members,
  });
}
