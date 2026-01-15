import 'package:flutter/material.dart';
import 'package:task_flow/models/team.dart';
import 'package:task_flow/models/user.dart';

class TeamProvider with ChangeNotifier {
  List<Team> _teams = [];
  bool _isLoading = false;

  List<Team> get teams => _teams;
  bool get isLoading => _isLoading;

  TeamProvider() {
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    _isLoading = true;
    notifyListeners();

    // Mock data
    final mockUsers = [
      User(id: '1', name: 'Alice', avatarUrl: 'assets/avatars/afro-kid.jpg'),
      User(id: '2', name: 'Bob', avatarUrl: 'assets/avatars/brown-hair-girl.jpg'),
      User(id: '3', name: 'Charlie', avatarUrl: 'assets/avatars/girl.jpg'),
      User(id: '4', name: 'David', avatarUrl: 'assets/avatars/flat-top-boy.jpg'),
      User(id: '5', name: 'Eve', avatarUrl: 'assets/avatars/braid-girl.jpg'),
    ];

    _teams = [
      Team(
        id: 'engineering',
        name: 'Engineering',
        members: [mockUsers[0], mockUsers[1], mockUsers[2]],
      ),
      Team(
        id: 'marketing',
        name: 'Marketing',
        members: [mockUsers[3], mockUsers[4]],
      ),
      Team(
        id: 'product',
        name: 'Product Design',
        members: [mockUsers[4], mockUsers[0]],
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  User getUser(String id) {
    final mockUsers = [
      User(id: '1', name: 'Alice', avatarUrl: 'assets/avatars/afro-kid.jpg'),
      User(id: '2', name: 'Bob', avatarUrl: 'assets/avatars/brown-hair-girl.jpg'),
      User(id: '3', name: 'Charlie', avatarUrl: 'assets/avatars/girl.jpg'),
      User(id: '4', name: 'David', avatarUrl: 'assets/avatars/flat-top-boy.jpg'),
      User(id: '5', name: 'Eve', avatarUrl: 'assets/avatars/braid-girl.jpg'),
    ];

    return mockUsers.firstWhere((user) => user.id == id);
  }
}
