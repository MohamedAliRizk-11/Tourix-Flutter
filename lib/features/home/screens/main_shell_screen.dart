import 'package:flutter/material.dart';
import '../../../core/widgets/app_bottom_nav_bar.dart';
import '../../discover/screens/discover_screen.dart';
import '../../ai_trip_planner/screens/ai_trip_planner_screen.dart';
import '../../map/screens/map_screen.dart';
import '../../quests/screens/quests_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  static const _screens = [
    DiscoverScreen(),
    AiTripPlannerScreen(),
    MapScreen(),
    QuestsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
