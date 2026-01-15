import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/providers/auth_provider.dart';
import 'package:task_flow/providers/navigation_provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/screens/all_tasks_screen.dart';
import 'package:task_flow/screens/create_update_task_screen.dart';
import 'package:task_flow/screens/profile_screen.dart';
import 'package:task_flow/screens/teams_screen.dart';
import 'package:task_flow/routes/app_page_route.dart';
import 'package:task_flow/widgets/bottom_nav_bar.dart';
import 'package:task_flow/widgets/task_card.dart';

import 'package:task_flow/screens/schedule_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _fabTurns = 0;

  static const List<Widget> _screens = <Widget>[
    DashboardContent(),
    ScheduleScreen(),
    TeamsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    
    final navProvier = Provider.of<NavigationProvider>(context);
    final selectedIndex = navProvier.selectedIndex;
    final theme = Theme.of(context);

    return Scaffold(
      body: _screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: navProvier.setIndex,
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                setState(() {
                  _fabTurns += 1;
                });
                await Future.delayed(const Duration(milliseconds: 150));
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  AppPageRoute(
                    builder: (context) => const CreateUpdateTaskScreen(),
                  ),
                );
              },
              backgroundColor: theme.colorScheme.primary,
              child: AnimatedRotation(
                turns: _fabTurns,
                duration: const Duration(milliseconds: 1000),
                child: const Icon(
                  EvaIcons.plus,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.withValues(alpha: .2),
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authProvider.username ?? 'Alex Rivera',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    authProvider.email ?? 'alex.r@taskflow.io',
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(EvaIcons.bellOutline),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Tasks',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    AppPageRoute(
                      builder: (context) => const AllTasksScreen(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              if (taskProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (taskProvider.error != null) {
                return Center(child: Text('Error: ${taskProvider.error}'));
              }
              if (taskProvider.tasks.isEmpty) {
                return const Center(child: Text('No active tasks.'));
              }
              final recentTasks = List<Task>.from(taskProvider.tasks)
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
              final displayTasks = recentTasks.take(3).toList();

              return Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  for (final task in displayTasks)
                    SizedBox(
                      height: 220,
                      child: TaskCard(task: task),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
