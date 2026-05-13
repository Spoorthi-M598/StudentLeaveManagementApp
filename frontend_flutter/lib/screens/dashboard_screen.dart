import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Good Morning",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            Text(
              "Student",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 10),

          CircleAvatar(
            child: Icon(Icons.person),
          ),

          SizedBox(width: 16),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Leave Summary",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                _buildSummaryCard("12", "Total"),
                const SizedBox(width: 12),

                _buildSummaryCard("8", "Approved"),
                const SizedBox(width: 12),

                _buildSummaryCard("4", "Pending"),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String count, String title) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          gradient: const LinearGradient(
            colors: [
              Color(0xFF3F51B5),
              Color(0xFF5C6BC0),
            ],
          ),

          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          children: [

            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

          ],
        ),
      ),
    );
  }
}