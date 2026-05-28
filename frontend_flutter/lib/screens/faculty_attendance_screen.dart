import 'package:flutter/material.dart';

import '../services/faculty_service.dart';

class FacultyAttendanceScreen
    extends StatefulWidget {

  const FacultyAttendanceScreen({
    super.key,
  });

  @override
  State<FacultyAttendanceScreen>
      createState() =>
          _FacultyAttendanceScreenState();
}

class _FacultyAttendanceScreenState
    extends State<
        FacultyAttendanceScreen> {

  List records = [];

  @override
  void initState() {
    super.initState();

    loadAttendance();
  }

  Future loadAttendance() async {

    final data =
        await FacultyService
            .getAttendance();

    setState(() {

      records = data;
    });
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Attendance Records",
        ),
      ),

      body: ListView.builder(

        itemCount:
            records.length,

        itemBuilder:
            (
              context,
              index,
            ) {

          final record =
              records[index];

          return Card(

            margin:
                const EdgeInsets
                    .all(12),

            child: ListTile(

              title: Text(
                record[
                    "student_name"],
              ),

              subtitle: Text(
                "${record["subject"]} • ${record["date"]}",
              ),

              trailing: Text(
                record[
                    "status"],
              ),
            ),
          );
        },
      ),
    );
  }
}