import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/task_provider.dart';
import 'package:task_flow/widgets/schedule_timeline_item.dart';

class ScheduleTimelineScreen extends StatefulWidget {
  const ScheduleTimelineScreen({super.key});

  @override
  State<ScheduleTimelineScreen> createState() => _ScheduleTimelineScreenState();
}

class _ScheduleTimelineScreenState extends State<ScheduleTimelineScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasksForDate(_selectedDate);
    tasks.sort((a, b) => (a.startTime?.hour ?? 0).compareTo(b.startTime?.hour ?? 0));

    return Column(
      children: [
        _buildDateSelector(),
        const SizedBox(height: 15,),
        Expanded(
          child: tasks.isEmpty
              ? const Center(child: Text('No tasks for today.'))
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 15,),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ScheduleTimelineItem(task: tasks[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          final date = DateTime.now().add(Duration(days: index - 2));
          final isSelected = date.day == _selectedDate.day;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 65,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date).toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
