import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AcademicReportScreen extends StatelessWidget {
  const AcademicReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments;

    Map data = {};

    if (args != null) {
      data = args as Map;
    }

    // ✅ REAL TIMETABLE SUBJECTS
    List<String> subjects = [
      "AMCS - Applied Mathematics",
      "PHY - Applied Physics",
      "FCN - Computer Networks",
      "FDBMS - DBMS",
      "PP - Python Programming",
      "DSA - Data Structures",
    ];

    int missedClasses = data["days"] != null
        ? (data["days"] * 5)
        : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EC),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF6F4E37),

        title: const Text(
          "Academic Report",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ✅ LEAVE DETAILS CARD
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),

                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey.shade300,
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Leave Details",

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Leave Type : ${data["leaveType"] ?? ""}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Start Date : ${data["startDate"] ?? ""}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "End Date : ${data["endDate"] ?? ""}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Total Days : ${data["days"] ?? 0}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ MISSED CLASSES
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Text(
                "Missed Classes : $missedClasses",

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Subjects Affected",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ✅ SUBJECT LIST
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,

                itemBuilder:
                    (context, index) {

                  return Card(
                    elevation: 3,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              15),
                    ),

                    margin:
                        const EdgeInsets.only(
                            bottom: 12),

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Colors.brown.shade100,

                        child: const Icon(
                          Icons.book,
                          color: Colors.brown,
                        ),
                      ),

                      title: Text(
                        subjects[index],

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ✅ SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6F4E37),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            15),
                  ),
                ),

                onPressed: () async {

                  final messenger =
                      ScaffoldMessenger.of(
                          context);

                  final navigator =
                      Navigator.of(context);

                  final success =
                      await ApiService
                          .applyLeave(
                    leaveType:
                        data['leaveType']
                                ?.toString() ??
                            '',

                    startDate:
                        data['startDate']
                                ?.toString() ??
                            '',

                    endDate:
                        data['endDate']
                                ?.toString() ??
                            '',

                    days: data['days']
                            is int
                        ? data['days']
                        : int.tryParse(
                                data['days']
                                        ?.toString() ??
                                    '0') ??
                            0,

                    reason:
                        data['reason']
                                ?.toString() ??
                            '',
                  );

                  if (success) {

                    navigator
                        .pushReplacementNamed(
                      "/success",
                      arguments: data,
                    );

                  } else {

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Failed to submit leave",
                        ),
                      ),
                    );
                  }
                },

                child: const Text(
                  "Submit Leave",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}