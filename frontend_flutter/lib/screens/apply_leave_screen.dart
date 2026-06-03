import 'package:flutter/material.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() =>
      _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState
    extends State<ApplyLeaveScreen> {

  // =========================
  // CONTROLLERS
  // =========================

  final TextEditingController startDateController =
      TextEditingController();

  final TextEditingController endDateController =
      TextEditingController();

  final TextEditingController reasonController =
      TextEditingController();

  // =========================
  // VARIABLES
  // =========================

  String selectedLeave = "Medical Leave";

  int totalDays = 0;

  // =========================
  // LEAVE TYPES
  // =========================

  final List<String> leaveTypes = [

    "Medical Leave",
    "Hackathon",
    "Sports Leave",
    "Internship",
    "Workshop",

  ];

  // =========================
  // HOLIDAYS
  // =========================

  final List<DateTime> holidays = [

    DateTime(2026, 3, 19),
    DateTime(2026, 3, 21),
    DateTime(2026, 4, 20),
    DateTime(2026, 5, 1),

  ];

  // =========================
  // SEMESTER DATES
  // =========================

  final DateTime semesterStart =
      DateTime(2026, 3, 5);

  final DateTime semesterEnd =
      DateTime(2026, 6, 24);

  // =========================
  // CHECK HOLIDAY
  // =========================

  bool isHoliday(DateTime date) {

    for (var holiday in holidays) {

      if (holiday.year == date.year &&
          holiday.month == date.month &&
          holiday.day == date.day) {

        return true;
      }
    }

    return false;
  }

  // =========================
  // CHECK SUNDAY
  // =========================

  bool isSunday(DateTime date) {

    return date.weekday == DateTime.sunday;
  }

  // =========================
  // CALCULATE WORKING DAYS
  // =========================

  void calculateDays() {

    try {

      if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty) {

        List<String> start =
        startDateController.text.split("-");

        List<String> end =
        endDateController.text.split("-");

        DateTime s = DateTime(

          int.parse(start[2]),
          int.parse(start[1]),
          int.parse(start[0]),

        );

        DateTime e = DateTime(

          int.parse(end[2]),
          int.parse(end[1]),
          int.parse(end[0]),

        );

        // =========================
        // TODAY DATE
        // =========================

        DateTime today = DateTime.now();

        today = DateTime(
          today.year,
          today.month,
          today.day,
        );

        // ❌ PAST DATE

        if (s.isBefore(today)) {

          ScaffoldMessenger.of(context).showSnackBar(

            const SnackBar(

              content: Text(
                "Past dates are not allowed",
              ),
            ),
          );

          setState(() {
            totalDays = 0;
          });

          return;
        }

        // ❌ END BEFORE START

        if (e.isBefore(s)) {

          ScaffoldMessenger.of(context).showSnackBar(

            const SnackBar(

              content: Text(
                "End date cannot be before start date",
              ),
            ),
          );

          setState(() {
            totalDays = 0;
          });

          return;
        }

        // ❌ BEFORE SEMESTER

        if (s.isBefore(semesterStart)) {

          ScaffoldMessenger.of(context).showSnackBar(

            const SnackBar(

              content: Text(
                "Semester not started",
              ),
            ),
          );

          setState(() {
            totalDays = 0;
          });

          return;
        }

        // ❌ AFTER SEMESTER

        if (e.isAfter(semesterEnd)) {

          ScaffoldMessenger.of(context).showSnackBar(

            const SnackBar(

              content: Text(
                "Semester already ended",
              ),
            ),
          );

          setState(() {
            totalDays = 0;
          });

          return;
        }

        // =========================
        // COUNT ONLY WORKING DAYS
        // =========================

        int workingDays = 0;

        DateTime current = s;

        while (!current.isAfter(e)) {

          bool sunday =
          isSunday(current);

          bool holiday =
          isHoliday(current);

          // COUNT ONLY WORKING DAYS

          if (!sunday && !holiday) {

            workingDays++;
          }

          current =
              current.add(
                const Duration(days: 1),
              );
        }

        // ❌ ONLY HOLIDAYS/SUNDAYS

        if (workingDays == 0) {

          ScaffoldMessenger.of(context).showSnackBar(

            const SnackBar(

              content: Text(
                "Selected dates contain only holidays",
              ),
            ),
          );

          setState(() {
            totalDays = 0;
          });

          return;
        }

        // ✅ FINAL TOTAL DAYS

        setState(() {

          totalDays = workingDays;

        });
      }

    } catch (e) {

      setState(() {

        totalDays = 0;

      });
    }
  }

  // =========================
  // BUTTON CLICK
  // =========================

  void checkAcademicReport() {

    // ❌ EMPTY FIELDS

    if (startDateController.text.isEmpty ||
        endDateController.text.isEmpty ||
        reasonController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    // ❌ INVALID DAYS

    if (totalDays <= 0) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Invalid leave dates",
          ),
        ),
      );

      return;
    }

    // ✅ NAVIGATE

    Navigator.pushNamed(

      context,

      "/academic",

      arguments: {

        "leaveType": selectedLeave,

        "days": totalDays,

        "startDate":
        startDateController.text,

        "endDate":
        endDateController.text,

        "reason":
        reasonController.text,

        "missed_classes":
        totalDays * 5,

        // =========================
        // YOUR REAL SUBJECTS
        // =========================

        "subjects": [

          "Applied Mathematics",
          "Applied Physics",
          "Computer Networks",
          "DBMS",
          "Python Programming",
          "Data Structures",
          "Aptitude",

        ],
      },
    );
  }

  // =========================
  // DATE PICKER
  // =========================

  Future<void> pickDate(
      TextEditingController controller) async {

    DateTime today = DateTime.now();

    DateTime firstAllowedDate = DateTime(

      today.year,
      today.month,
      today.day,

    );

    // IF TODAY BEFORE SEMESTER

    if (firstAllowedDate.isBefore(semesterStart)) {

      firstAllowedDate = semesterStart;
    }

    DateTime? picked = await showDatePicker(

      context: context,

      firstDate: firstAllowedDate,

      lastDate: semesterEnd,

      initialDate: firstAllowedDate,
    );

    if (picked != null) {

      String formatted =

          "${picked.day.toString().padLeft(2, '0')}-"
          "${picked.month.toString().padLeft(2, '0')}-"
          "${picked.year}";

      setState(() {

        controller.text = formatted;

      });

      calculateDays();
    }
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {

    startDateController.dispose();

    endDateController.dispose();

    reasonController.dispose();

    super.dispose();
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F1EC),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFF6F4E37),

        title: const Text(
          "Apply Leave",
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding:
          const EdgeInsets.all(16),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const Text(

                "Apply Leave Form",

                style: TextStyle(

                  fontSize: 28,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // LEAVE TYPE
              // =========================

              DropdownButtonFormField(

                value: selectedLeave,

                items: leaveTypes.map((e) {

                  return DropdownMenuItem(

                    value: e,

                    child: Text(e),
                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {

                    selectedLeave = value!;

                  });
                },

                decoration:
                const InputDecoration(

                  labelText: "Leave Type",

                  border:
                  OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // START DATE
              // =========================

              TextField(

                controller:
                startDateController,

                readOnly: true,

                decoration:
                const InputDecoration(

                  labelText: "Start Date",

                  border:
                  OutlineInputBorder(),

                  suffixIcon:
                  Icon(Icons.calendar_month),
                ),

                onTap: () =>
                    pickDate(startDateController),
              ),

              const SizedBox(height: 20),

              // =========================
              // END DATE
              // =========================

              TextField(

                controller:
                endDateController,

                readOnly: true,

                decoration:
                const InputDecoration(

                  labelText: "End Date",

                  border:
                  OutlineInputBorder(),

                  suffixIcon:
                  Icon(Icons.calendar_month),
                ),

                onTap: () =>
                    pickDate(endDateController),
              ),

              const SizedBox(height: 20),

              // =========================
              // REASON
              // =========================

              TextField(

                controller:
                reasonController,

                maxLines: 4,

                decoration:
                const InputDecoration(

                  labelText: "Reason",

                  border:
                  OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // TOTAL DAYS
              // =========================

              Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(15),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(10),
                ),

                child: Text(

                  "Total Working Days : $totalDays",

                  style: const TextStyle(

                    fontSize: 20,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // BUTTON
              // =========================

              SizedBox(

                width: double.infinity,

                height: 55,

                child: ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    const Color(0xFF6F4E37),
                  ),

                  onPressed:
                  checkAcademicReport,

                  child: const Text(

                    "Check Academic Report",

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
      ),
    );
  }
}