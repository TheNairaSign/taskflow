import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/team.dart';
import 'package:task_flow/providers/task_provider.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasksForTeam(team.id);
    final activeTasks = tasks.where((task) => task.status != 'completed').length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.announcement, color: Colors.blue,),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // const SizedBox(height: 5.0),
                    Text('$activeTasks Active Tasks', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blue),),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(EvaIcons.arrowIosForwardOutline, color: Colors.grey,),
                  onPressed: () {},
              ),
              ],
            ),
            
            const SizedBox(height: 15.0),
            Row(
              children: [
                ...team.members.take(3).map((user) {
                  return CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  );
                }),
                if (team.members.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: CircleAvatar(
                      child: Text('+${team.members.length - 3}'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
