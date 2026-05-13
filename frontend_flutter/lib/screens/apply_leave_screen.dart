import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {

  String leaveType = "Medical";
  final reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F51B5),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("Apply Leave"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),

            boxShadow: const [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black12,
              )
            ],
          ),

          child: Column(
            children: [

              DropdownButtonFormField(
                initialValue: leaveType,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),

                items: const [
                  DropdownMenuItem(
                    value: "Medical",
                    child: Text("Medical"),
                  ),

                  DropdownMenuItem(
                    value: "Personal",
                    child: Text("Personal"),
                  ),

                  DropdownMenuItem(
                    value: "Emergency",
                    child: Text("Emergency"),
                  ),
                ],

                onChanged: (value){
                  setState(() {
                    leaveType = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: reasonController,
                maxLines: 4,

                decoration: InputDecoration(
                  hintText: "Enter reason",

                  filled: true,
                  fillColor: Colors.grey.shade100,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                height: 55,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3F51B5),
                      Color(0xFF5C6BC0),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: ElevatedButton(
                onPressed: () async {

  bool success = await ApiService.applyLeave(
    studentId: 1,
    reason: reasonController.text,
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        success
          ? "Leave Submitted Successfully"
          : "Submission Failed",
      ),
    ),
  );
},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),

                  child: const Text(
                    "Submit Leave",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}