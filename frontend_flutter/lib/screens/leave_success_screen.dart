import 'package:flutter/material.dart';

class LeaveSuccessScreen extends StatelessWidget {
  const LeaveSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};

    final leaveType = data['leaveType']?.toString() ?? '';
    final startDate = data['startDate']?.toString() ?? '';
    final endDate = data['endDate']?.toString() ?? '';
    final days = data['days']?.toString() ?? '0';
    final reason = data['reason']?.toString() ?? '';

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFDFF5E1),
                child: Icon(Icons.check,
                    color: Colors.green, size: 60),
              ),

              const SizedBox(height: 30),

              const Text(
                "Leave Application Submitted!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.shade300),
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text("Leave Type : $leaveType"),
                    Text("Start Date : $startDate"),
                    Text("End Date : $endDate"),
                    Text("Total Days : $days"),
                    Text("Reason : $reason"),

                    const SizedBox(height: 10),

                    const Text(
                      "Status : Pending Mentor Approval",
                    ),

                    const Text(
                      "Application ID : LV2026",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize:
                      const Size(double.infinity, 55),
                ),

                onPressed: () {

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/home", // ✅ GO DASHBOARD
                    (route) => false,
                  );
                },

                child: const Text(
                  "Back to Dashboard",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}