import 'package:flutter/material.dart';
import 'leave_success_screen.dart';

class AcademicImpactScreen extends StatelessWidget {
  const AcademicImpactScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> subjects = [

      {
        "name": "DBMS",
        "current": "88%",
        "after": "86%",
        "status": "Safe",
        "color": Colors.green,
      },

      {
        "name": "ATC",
        "current": "85%",
        "after": "84%",
        "status": "Below 85%",
        "color": Colors.red,
      },

      {
        "name": "Java Lab",
        "current": "90%",
        "after": "89%",
        "status": "Safe",
        "color": Colors.green,
      },

      {
        "name": "CN",
        "current": "87%",
        "after": "85%",
        "status": "Borderline",
        "color": Colors.orange,
      },

      {
        "name": "WT",
        "current": "91%",
        "after": "90%",
        "status": "Safe",
        "color": Colors.green,
      },

    ];

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Academic Impact",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Container(

                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Row(

                  children: [

                    Icon(Icons.warning,color: Colors.red),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "ATC will fall below 85% if leave is approved.",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )

                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Attendance Impact Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(

                  children: [

                    Container(

                      padding: const EdgeInsets.all(12),
                      color: Colors.grey.shade200,

                      child: const Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Expanded(child: Text("Subject")),
                          Expanded(child: Text("Current %")),
                          Expanded(child: Text("After Leave")),
                          Expanded(child: Text("Status")),

                        ],
                      ),
                    ),

                    ...subjects.map((subject) {

                      return Container(

                        padding: const EdgeInsets.all(12),

                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Expanded(
                              child: Text(subject["name"]),
                            ),

                            Expanded(
                              child: Text(subject["current"]),
                            ),

                            Expanded(
                              child: Text(subject["after"]),
                            ),

                            Expanded(
                              child: Text(
                                subject["status"],
                                style: TextStyle(
                                  color: subject["color"],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          ],
                        ),
                      );

                    }).toList(),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("• Total Academic Loss: 5 Hours"),

                    SizedBox(height: 5),

                    Text("• Classes to be missed: 5"),

                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const LeaveSuccessScreen(),
                      ),
                    );

                  },

                  child: const Text(
                    "Proceed & Submit Leave",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
