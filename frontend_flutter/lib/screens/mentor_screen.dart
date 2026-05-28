import 'package:flutter/material.dart';

import '../services/mentor_service.dart';

class MentorScreen extends StatefulWidget {

  const MentorScreen({
    super.key,
  });

  @override
  State<MentorScreen> createState() =>
      _MentorScreenState();
}

class _MentorScreenState
    extends State<MentorScreen> {

  List leaves = [];

  @override
  void initState() {
    super.initState();

    loadLeaves();
  }

  Future loadLeaves() async {

    final data =
        await MentorService
            .getLeaves();

    setState(() {
      leaves = data;
    });
  }

  Future approve(
      int leaveId) async {

    await MentorService
        .approveLeave(
            leaveId);

    loadLeaves();
  }

  Future reject(
      int leaveId) async {

    await MentorService
        .rejectLeave(
            leaveId);

    loadLeaves();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
              0xFFF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Mentor Dashboard",
        ),

      
      ),

      body: ListView.builder(

        padding:
            const EdgeInsets
                .all(16),

        itemCount:
            leaves.length,

        itemBuilder:
            (
              context,
              index,
            ) {

          final leave =
              leaves[index];

          return Container(

            margin:
                const EdgeInsets
                    .only(
                        bottom:
                            16),

            padding:
                const EdgeInsets
                    .all(18),

            decoration:
                BoxDecoration(

              color:
                  Colors.white,

              borderRadius:
                  BorderRadius
                      .circular(
                          20),

              boxShadow: [

                BoxShadow(
                  color: Colors
                      .black12,

                  blurRadius:
                      12,
                )
              ],
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  leave[
                      "student_name"],

                  style:
                      const TextStyle(
                    fontSize:
                        18,

                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                const SizedBox(
                    height: 8),

                Text(
                  leave[
                      "reason"],
                ),

                const SizedBox(
                    height: 8),

                Text(
                  "${leave["from_date"]} → ${leave["to_date"]}",
                ),

                const SizedBox(
                    height: 12),

                Row(

                  children: [

                    Expanded(
                      child:
                          ElevatedButton(

                        onPressed:
                            () =>
                                approve(
                          leave[
                              "leave_id"],
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green,
                        ),

                        child:
                            const Text(
                          "Approve",
                        ),
                      ),
                    ),

                    const SizedBox(
                        width: 10),

                    Expanded(
                      child:
                          ElevatedButton(

                        onPressed:
                            () =>
                                reject(
                          leave[
                              "leave_id"],
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red,
                        ),

                        child:
                            const Text(
                          "Reject",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}