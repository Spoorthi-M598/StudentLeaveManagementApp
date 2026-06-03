import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Details"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Overall Attendance",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            const Text(
              "82%",
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Subject Wise Attendance",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            buildRow("DBMS", "88%"),
            buildRow("ATC", "86%"),
            buildRow("Java Lab", "90%"),
            buildRow("CN", "87%"),
            buildRow("WT", "91%"),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String subject, String percent) {
    return ListTile(
      title: Text(subject),
      trailing: Text(percent),
    );
  }
}