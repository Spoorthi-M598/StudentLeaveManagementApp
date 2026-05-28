import 'package:flutter/material.dart';
import '../services/attendance_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() =>
      _AttendanceScreenState();
}

class _AttendanceScreenState
    extends State<AttendanceScreen> {

  final studentIdController =
      TextEditingController();

  final subjectController =
      TextEditingController();

  String status = "Present";

  bool loading = false;

  Future<void> markAttendance() async {

    setState(() {
      loading = true;
    });

    try {

      final message =
          await AttendanceService.markAttendance(

        studentId:
            studentIdController.text,

        subject:
            subjectController.text,

        status:
            status,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Mark Attendance",
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller:
                  studentIdController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Student ID",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  subjectController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Subject",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(

              value: status,

              items: const [

                DropdownMenuItem(
                  value: "Present",
                  child: Text("Present"),
                ),

                DropdownMenuItem(
                  value: "Absent",
                  child: Text("Absent"),
                ),
              ],

              onChanged: (value) {

                setState(() {
                  status = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed:
                  loading
                      ? null
                      : markAttendance,

              child: Text(

                loading
                    ? "Saving..."
                    : "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}