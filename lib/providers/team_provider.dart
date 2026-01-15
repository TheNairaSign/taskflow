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
      User(id: '1', name: 'Alice', avatarUrl: 'https://i.pravatar.cc/150?u=alice'),
      User(id: '2', name: 'Bob', avatarUrl: 'https://i.pravatar.cc/150?u=bob'),
      User(id: '3', name: 'Charlie', avatarUrl: 'https://i.pravatar.cc/150?u=charlie'),
      User(id: '4', name: 'David', avatarUrl: 'https://i.pravatar.cc/150?u=david'),
      User(id: '5', name: 'Eve', avatarUrl: 'https://i.pravatar.cc/150?u=eve'),
      User(id: '6', name: 'Frank', avatarUrl: 'https://i.pravatar.cc/150?u=frank'),
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
        members: [mockUsers[5], mockUsers[0]],
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  User getUser(String id) {
    final mockUsers = [
      User(id: '1', name: 'Alice', avatarUrl: 'https://i.pravatar.cc/150?u=alice'),
      User(id: '2', name: 'Bob', avatarUrl: 'https://i.pravatar.cc/150?u=bob'),
      User(id: '3', name: 'Charlie', avatarUrl: 'https://i.pravatar.cc/150?u=charlie'),
      User(id: '4', name: 'David', avatarUrl: 'https://i.pravatar.cc/150?u=david'),
      User(id: '5', name: 'Eve', avatarUrl: 'https://i.pravatar.cc/150?u=eve'),
      User(id: '6', name: 'Frank', avatarUrl: 'https://i.pravatar.cc/150?u=frank'),
    ];

    return mockUsers.firstWhere((user) => user.id == id);
  }
}
