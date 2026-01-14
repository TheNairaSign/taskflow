import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/screens/all_tasks_screen.dart';
import 'package:task_flow/screens/create_update_task_screen.dart';
import 'package:task_flow/screens/profile_screen.dart';
import 'package:task_flow/widgets/bottom_nav_bar.dart';
import 'package:task_flow/widgets/task_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    DashboardContent(),
    Scaffold(body: Center(child: Text('Schedule'))),
    Scaffold(body: Center(child: Text('Team'))),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
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
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
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
                    MaterialPageRoute(
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
              if (taskProvider.tasks.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.tasks[index];
                    return TaskCard(task: task);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
