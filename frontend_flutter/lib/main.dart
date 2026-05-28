import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'utils/theme.dart';



void main() {
  runApp(const LeaveApp());
}

class LeaveApp extends StatelessWidget {
  const LeaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leave Management',
      theme: AppTheme.lightTheme,
     home: const LoginScreen(),
      
    );
  }
}