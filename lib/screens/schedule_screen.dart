import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_flow/screens/schedule_calendar_screen.dart';
import 'package:task_flow/screens/schedule_timeline_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  int _segIndex = 0;
  late TabController _tabController;
  Animation<double>? _tabAnim;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChanged);
    _tabAnim = _tabController.animation;
    _tabAnim?.addListener(_handleTabAnimation);
  }

  void _handleTabChanged() {
    if (_segIndex != _tabController.index) {
      setState(() {
        _segIndex = _tabController.index;
      });
    }
  }
  void _handleTabAnimation() {
    final v = _tabAnim?.value ?? _tabController.index.toDouble();
    final nextIndex = v >= 0.5 ? 1 : 0;
    if (_segIndex != nextIndex) {
      setState(() {
        _segIndex = nextIndex;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChanged);
    _tabAnim?.removeListener(_handleTabAnimation);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: segmentedControl(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ScheduleTimelineScreen(),
                ScheduleCalendarScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox segmentedControl() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: _segIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.2) : theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _segIndex = 0;
                      });
                      _tabController.animateTo(0, duration: Duration.zero, curve: Curves.linear);
                    },
                    child: Center(
                      child: Text(
                        'List',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: _segIndex == 0
                              ? Colors.white
                              : theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _segIndex = 1;
                      });
                      _tabController.animateTo(1, duration: Duration.zero, curve: Curves.linear);
                    },
                    child: Center(
                      child: Text(
                        'Calendar',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: _segIndex == 1
                              ? Colors.white
                              : theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                        ),
                      ),
                    ),
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
