import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/screens/all_tasks_screen.dart';
import 'package:task_flow/screens/create_update_task_screen.dart';
import 'package:task_flow/screens/profile_screen.dart';
import 'package:task_flow/routes/app_page_route.dart';
import 'package:task_flow/widgets/bottom_nav_bar.dart';
import 'package:task_flow/widgets/task_card.dart';
import 'package:task_flow/models/task.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    DashboardContent(),
    Scaffold(body: Center(child: Text('Schedule'))),
    Scaffold(body: Center(child: Text('Team'))),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    
    final navProvier = Provider.of<NavigationProvider>(context);
    final selectedIndex = navProvier.currentIndex;
    final theme = Theme.of(context);

    return Scaffold(
      body: _screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: navProvier.updateIndex,
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  AppPageRoute(
                    builder: (context) => const CreateUpdateTaskScreen(),
                  ),
                );
              },
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(EvaIcons.plus),
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
    final theme = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=500&h=500&fit=crop'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alex Rivera',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'alex.r@taskflow.io',
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
              // Sort by ID descending to get newest tasks and take top 3
              final recentTasks = List<Task>.from(taskProvider.tasks)
                ..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
              final displayTasks = recentTasks.take(3).toList();

              return Column(
                spacing: 15,
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

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
