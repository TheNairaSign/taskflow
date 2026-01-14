import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.colorScheme.surface,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.homeOutline),
          activeIcon: Icon(EvaIcons.home),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.calendarOutline),
          activeIcon: Icon(EvaIcons.calendar),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.peopleOutline),
          activeIcon: Icon(EvaIcons.people),
          label: 'Team',
        ),
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.settingsOutline),
          activeIcon: Icon(EvaIcons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}