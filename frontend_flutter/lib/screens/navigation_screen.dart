import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'apply_leave_screen.dart';
import 'student_attendance.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class NavigationScreen
    extends StatefulWidget {

  const NavigationScreen({
    super.key,
  });

  @override
  State<NavigationScreen>
      createState() =>
          _NavigationScreen();
}

class _NavigationScreen
    extends State<
        NavigationScreen> {

  int currentIndex = 0;

  final List<Widget> pages = [

    const DashboardScreen(),

    const ApplyLeaveScreen(),

    const StudentAttendanceScreen(),

    const HistoryScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      body: pages[
          currentIndex],

      bottomNavigationBar:
          BottomNavigationBar(

        type:
            BottomNavigationBarType
                .fixed,

        currentIndex:
            currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex =
                index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(
                Icons.dashboard),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(
                Icons.edit_calendar),
            label: "Apply",
          ),

          BottomNavigationBarItem(
            icon: Icon(
                Icons.fact_check),
            label:
                "Attendance",
          ),

          BottomNavigationBarItem(
            icon: Icon(
                Icons.history),
            label:
                "History",
          ),

          BottomNavigationBarItem(
            icon: Icon(
                Icons.person),
            label:
                "Profile",
          ),
        ],
      ),
    );
  }
}