import 'package:flutter/material.dart';

import '../services/student_service.dart';

class StudentAttendanceScreen
    extends StatefulWidget {

  const StudentAttendanceScreen({
    super.key,
  });

  @override
  State<StudentAttendanceScreen>
      createState() =>
          _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState
    extends State<
        StudentAttendanceScreen> {

  List subjects = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadAttendance();
  }

  Future<void>
      loadAttendance() async {

    try {

      final data =
          await StudentService
              .getAttendancePercentage();

      setState(() {

        subjects = data;
        loading = false;
      });

    } catch (e) {

      setState(() {

        loading = false;
      });
    }
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
          "Attendance Report",
        ),
      ),

      body:

          loading

              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : subjects.isEmpty

                  ? const Center(
                      child: Text(
                        "No attendance found",
                      ),
                    )

                  : ListView.builder(

                      padding:
                          const EdgeInsets
                              .all(16),

                      itemCount:
                          subjects.length,

                      itemBuilder:
                          (
                            context,
                            index,
                          ) {

                        final subject =
                            subjects[
                                index];

                        final percentage =
                            subject[
                                "percentage"];

                        return Card(

                          margin:
                              const EdgeInsets
                                  .only(
                                      bottom:
                                          16),

                          child: ListTile(

                            title: Text(
                              subject[
                                  "subject"],
                            ),

                            subtitle:
                                Text(
                              "$percentage%",
                            ),

                            trailing:
                                percentage < 75

                                    ? const Icon(
                                        Icons
                                            .warning,
                                        color:
                                            Colors.red,
                                      )

                                    : const Icon(
                                        Icons
                                            .check_circle,
                                        color:
                                            Colors.green,
                                      ),
                          ),
                        );
                      },
                    ),
    );
  }
}