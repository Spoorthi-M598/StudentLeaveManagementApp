import 'package:flutter/material.dart';

import '../models/leave_model.dart';
import '../services/leave_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FA),

      appBar: AppBar(
        title:
            const Text(
                "My Leaves"),
        centerTitle: true,
      ),

      body:
          FutureBuilder<
              List<LeaveModel>>(
        future:
            LeaveService
                .getHistory(),

        builder:
            (context, snapshot) {

          if (snapshot
                  .connectionState ==
              ConnectionState
                  .waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot
              .hasError) {
            return Center(
              child: Text(
                snapshot.error
                    .toString(),
              ),
            );
          }

          final leaves =
              snapshot.data!;

          if (leaves.isEmpty) {
            return const Center(
              child: Text(
                  "No leave history"),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets
                    .all(20),

            itemCount:
                leaves.length,

            itemBuilder:
                (context, index) {

              final leave =
                  leaves[index];

              return Container(
                margin:
                    const EdgeInsets
                        .only(
                            bottom:
                                18),

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
                              24),

                  boxShadow: [
                    BoxShadow(
                      color: Colors
                          .black12,

                      blurRadius:
                          15,
                    )
                  ],
                ),

                child: Row(
                  children: [

                    // Date badge
                    Container(
                      width: 60,
                      height: 60,

                      decoration:
                          BoxDecoration(
                        color: const Color(
                            0xFFEEF2FF),

                        borderRadius:
                            BorderRadius
                                .circular(
                                    18),
                      ),

                      child: const Icon(
                        Icons
                            .calendar_month,
                        color: Color(
                            0xFF3F51B5),
                      ),
                    ),

                    const SizedBox(
                        width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(
                            leave.reason,

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
                              height:
                                  6),

                          Text(
                            "${leave.fromDate} → ${leave.toDate}",

                            style:
                                TextStyle(
                              color: Colors
                                  .grey
                                  .shade700,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  10),

                          _statusChip(
                            leave.status,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _statusChip(
      String status) {

    Color color =
        Colors.orange;

    if (status
            .toLowerCase() ==
        "approved") {
      color =
          Colors.green;
    }

    if (status
            .toLowerCase() ==
        "rejected") {
      color =
          Colors.red;
    }

    return Container(
      padding:
          const EdgeInsets
              .symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration:
          BoxDecoration(
        color:
            color.withOpacity(
                0.15),

        borderRadius:
            BorderRadius
                .circular(20),
      ),

      child: Text(
        status,

        style: TextStyle(
          color: color,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}