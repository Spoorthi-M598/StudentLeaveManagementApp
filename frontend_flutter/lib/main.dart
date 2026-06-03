import 'package:flutter/material.dart';

// Import Screens
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/apply_leave_screen.dart';
import 'screens/academic_report_screen.dart';
import 'screens/leave_success_screen.dart';
import 'screens/my_leaves_screen.dart';
import 'screens/leave_quota_screen.dart';
import 'screens/attendance_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      initialRoute: "/login",

      routes: {

        // LOGIN
        "/login": (context) =>
        const LoginScreen(),

        // DASHBOARD
        "/home": (context) =>
        const DashboardScreen(),

        // APPLY LEAVE
        "/apply": (context) =>
        const ApplyLeaveScreen(),

        // ACADEMIC REPORT
        "/academic": (context) =>
        AcademicReportScreen(),

        // SUCCESS SCREEN
        "/success": (context) =>
        const LeaveSuccessScreen(),

        // MY LEAVES
        "/myLeaves": (context) =>
        const MyLeavesScreen(),

        // LEAVE QUOTA
        "/quota": (context) =>
        const LeaveQuotaScreen(),

        // ATTENDANCE
        "/attendance": (context) =>
        const AttendanceScreen(),
      },
    );
  }
}