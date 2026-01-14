import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/widgets/task_list_item.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowIosBackOutline),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'All Tasks',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.calendarOutline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.personOutline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search tasks, projects...',
              prefixIcon: const Icon(EvaIcons.searchOutline),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Pending'),
                _buildFilterChip('In Progress'),
                _buildFilterChip('Completed'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              if (taskProvider.tasks.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final filteredTasks = taskProvider.tasks.where((task) {
                if (_selectedFilter == 'All') {
                  return true;
                }
                return task.status.toLowerCase() ==
                    _selectedFilter.toLowerCase().replaceAll(' ', '_');
              }).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskListItem(task: task);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedFilter = label;
            });
          }
        },
        backgroundColor: const Color(0xFF1E1E1E),
        selectedColor: const Color(0xFF3D7BFF),
        labelStyle: GoogleFonts.inter(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
