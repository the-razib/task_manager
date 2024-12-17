import 'package:flutter/material.dart';
import 'package:task_manager_with_getx/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_with_getx/ui/screens/compeleted_task_screen.dart';
import 'package:task_manager_with_getx/ui/screens/new_task_screen.dart';
import 'package:task_manager_with_getx/ui/screens/progress_task_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_colors.dart';
import 'package:task_manager_with_getx/ui/widgets/task_manager_app_ber.dart';

class MainBottomNavBerScreen extends StatefulWidget {
  static const String name = '/main-bottom-nav-ber-screen';

  const MainBottomNavBerScreen({super.key});

  @override
  State<MainBottomNavBerScreen> createState() => _MainBottomNavBerScreenState();
}

class _MainBottomNavBerScreenState extends State<MainBottomNavBerScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBer(),  // Keep original AppBar
      body: _screens[_selectedIndex], // Body content based on selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: 'Cancelled',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled_outlined),
            label: 'Progress',
          ),
        ],
        selectedItemColor: AppColor.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        elevation: 5,  // Shadow for bottom navigation bar
      ),
    );
  }
}
