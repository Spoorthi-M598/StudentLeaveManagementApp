import 'package:flutter/material.dart';

class LeaveQuotaScreen extends StatelessWidget {
  const LeaveQuotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Quota"),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            buildRow("TC - Technical", 5, 1, 4),
            buildRow("CF - Cultural", 3, 1, 2),
            buildRow("Sports", 5, 0, 5),
            buildRow("Sick Leave", 6, 1, 5),
            buildRow("Emergency", 2, 0, 2),

          ],
        ),
      ),
    );
  }

  Widget buildRow(String type, int quota, int used, int balance) {
    return Card(
      child: ListTile(
        title: Text(type),
        subtitle: Text("Quota: $quota  Used: $used  Balance: $balance"),
      ),
    );
  }
}