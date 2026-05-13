import 'package:flutter/material.dart';

import 'utils/theme.dart';
import 'screens/home_screen.dart';


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
     home: const HomeScreen(),
      
    );
  }
}