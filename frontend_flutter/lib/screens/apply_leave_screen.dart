import 'package:flutter/material.dart';

import '../models/student_model.dart';
import '../services/student_service.dart';
import '../services/leave_service.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final reasonController = TextEditingController();

  String leaveType = "Medical";

  DateTime? startDate;
  DateTime? endDate;

  String missedClasses = "";
  String attachmentName = "No file chosen";
  String? attachmentPath;

  bool loading = false;

  final leaveTypes = [
    "Medical",
    "Personal",
    "Family Emergency",
    "Event / Competition",
    "Academic",
    "Other",
  ];

  Future pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;

        if (endDate != null && endDate!.isBefore(startDate!)) {
          endDate = null;
          missedClasses = "";
        }
      });

      await _updatePreview();
    }
  }

  Future pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        endDate = picked;
      });

      await _updatePreview();
    }
  }

  Future _updatePreview() async {
    if (startDate == null || endDate == null) {
      return;
    }

    if (endDate!.isBefore(startDate!)) {
      setState(() {
        missedClasses = "";
      });
      return;
    }

    try {
      final preview = await LeaveService.previewLeave(
        fromDate: startDate!.toString().split(" ").first,
        toDate: endDate!.toString().split(" ").first,
      );

      if (mounted) {
        setState(() {
          missedClasses = preview;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          missedClasses = "Unable to calculate missed classes.";
        });
      }
    }
  }

  Future pickAttachment() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.medical_information),
                title: const Text("Medical certificate"),
                onTap: () => Navigator.pop(context, "Medical certificate"),
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Event approval letter"),
                onTap: () => Navigator.pop(context, "Event approval letter"),
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text("Supporting document"),
                onTap: () => Navigator.pop(context, "Supporting document"),
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text("Cancel"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        attachmentName = result;
      });
    }
  }

  Future submitLeave() async {
    if (startDate == null ||
        endDate == null ||
        reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all required fields")));

      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final result = await LeaveService.applyLeave(
        fromDate: startDate!.toString().split(" ").first,

        toDate: endDate!.toString().split(" ").first,

        reason: reasonController.text,
        leaveType: leaveType,
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    setState(() {
      loading = false;
    });
  }

  Future showConfirmDialog() async {
    final result = await showDialog<bool>(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text("Confirm Leave"),

          content: const Text("Submit leave request to mentor?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              child: const Text("Submit"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      submitLeave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Student>(
      future: StudentService.getStudent(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final student = snapshot.data!;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F3F3),

          appBar: AppBar(
            backgroundColor: const Color(0xFF6F0F18),

            foregroundColor: Colors.white,

            title: const Text("Apply Leave"),
          ),

          body: ListView(
            padding: const EdgeInsets.all(16),

            children: [
              _sectionTitle("Leave Details"),
              Text(
                "Enter your leave details below.",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 12),

              _dropdownField("Leave Type", leaveType, leaveTypes, (value) {
                setState(() {
                  leaveType = value!;
                });
              }),

              const SizedBox(height: 15),

              _dateTile(
                "From Date",

                startDate == null
                    ? "Select"
                    : startDate!.toString().split(" ").first,

                pickStartDate,
              ),

              const SizedBox(height: 15),

              _dateTile(
                "To Date",

                endDate == null
                    ? "Select"
                    : endDate!.toString().split(" ").first,

                pickEndDate,
              ),

              const SizedBox(height: 20),

              _sectionTitle("Reason"),

              TextField(
                controller: reasonController,
                maxLines: 2,
                minLines: 2,
                decoration: _inputDecoration("Enter reason"),
              ),

              const SizedBox(height: 20),

              _sectionTitle("Attachment (Optional)"),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachmentName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Support document upload is optional. Attach medical certificates, approval letters, or other evidence.",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: pickAttachment,
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Choose File / Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F0F18),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (missedClasses.isNotEmpty) ...[
                _sectionTitle("Missed Classes"),

                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,

                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Text(missedClasses),
                ),

                const SizedBox(height: 20),
              ],

              _sectionTitle("Approval"),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.green.shade50,

                  borderRadius: BorderRadius.circular(15),
                ),

                child: Text(
                  "Mentor: ${student.mentorEmail}\n\nLeave request will be sent to mentor.",

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,

                child: ElevatedButton(
                  onPressed: loading ? null : showConfirmDialog,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F0F18),

                    foregroundColor: Colors.white,
                  ),

                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Submit Leave Request"),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Text(
        title,

        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dateTile(String title, String value, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,

      tileColor: Colors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      title: Text(title),

      trailing: Text(value),
    );
  }

  Widget _dropdownField(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField(
      initialValue: value,

      decoration: _inputDecoration(label),

      items: items.map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),

      onChanged: onChanged,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,

      filled: true,

      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide.none,
      ),
    );
  }
}
