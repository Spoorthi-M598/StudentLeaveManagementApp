import 'package:flutter/material.dart';
import '../data/leave_data.dart';

class MyLeavesScreen extends StatelessWidget {
  const MyLeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final leaves = LeaveData.getLeaves();

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "My Leaves",
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        backgroundColor: const Color(0xFF6F4E37),
      ),

      body: leaves.isEmpty

          ? const Center(
        child: Text(
          "No Leaves Applied",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      )

          : ListView.builder(

        padding: const EdgeInsets.all(10),

        itemCount: leaves.length,

        itemBuilder: (context, index) {

          final leave = leaves[index];

          return Card(

            elevation: 4,

            margin: const EdgeInsets.only(
              bottom: 15,
            ),

            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15),
            ),

            child: Padding(

              padding: const EdgeInsets.all(12),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    leave['leaveType'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Days : ${leave['days']}",
                  ),

                  Text(
                    "From : ${leave['startDate']}",
                  ),

                  Text(
                    "To : ${leave['endDate']}",
                  ),

                  Text(
                    "Reason : ${leave['reason']}",
                  ),

                  const SizedBox(height: 10),

                  Align(

                    alignment:
                    Alignment.centerRight,

                    child: Container(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(

                        color:
                        Colors.orange.shade100,

                        borderRadius:
                        BorderRadius.circular(
                            20),
                      ),

                      child: Text(

                        leave['status'],

                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}