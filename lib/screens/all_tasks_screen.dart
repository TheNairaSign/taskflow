import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/navigation_provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/widgets/task_card.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            onPressed: () {
              final navProvider = Provider.of<NavigationProvider>(context, listen: false);
              navProvider.setIndex(1);
              Navigator.of(context).pop();
            },
            icon: const Icon(EvaIcons.calendarOutline),
          ),
          IconButton(
            onPressed: () {
              final navProvider = Provider.of<NavigationProvider>(context, listen: false);
              navProvider.setIndex(3);
              Navigator.of(context).pop();
            },
            icon: const Icon(EvaIcons.personOutline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search tasks, projects...',
              prefixIcon: const Icon(EvaIcons.searchOutline),
              filled: true,
              fillColor: theme.colorScheme.surface,
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
              final query = _searchController.text.trim().toLowerCase();
              final filteredTasks = taskProvider.tasks.where((task) {
                final matchesSearch = query.isEmpty ||
                    task.title.toLowerCase().contains(query) ||
                    task.project.toLowerCase().contains(query) ||
                    task.description.toLowerCase().contains(query);
                if (!matchesSearch) return false;
                if (_selectedFilter == 'All') return true;
                final normalized = (task.status ?? 'pending').toLowerCase();
                return normalized == _selectedFilter.toLowerCase().replaceAll(' ', '_');
              }).toList();
              filteredTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return SizedBox(
                    height: 220,
                    child: TaskCard(task: task)
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final theme = Theme.of(context);
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        side: BorderSide.none,
        label: Text(label),
        selected: isSelected,
        checkmarkColor: Colors.white,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedFilter = label;
            });
          }
        },
        backgroundColor: theme.colorScheme.surface,
        selectedColor: theme.colorScheme.primary,
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          color: isSelected
              ? Colors.white
              : theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
