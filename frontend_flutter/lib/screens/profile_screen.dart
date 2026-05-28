import 'package:flutter/material.dart';

import '../models/student_model.dart';
import '../services/student_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F3),

      body: FutureBuilder<Student>(
        future: StudentService.getStudent(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final student = snapshot.data!;

          return SingleChildScrollView(

            child: Column(

              children: [

                // TOP BAR
                Container(

                  padding: const EdgeInsets.only(
                    top: 45,
                    left: 16,
                    right: 16,
                    bottom: 18,
                  ),

                  color: const Color(0xFF6F0F18),

                  child: Row(

                    children: [

                      // University logo
                      Container(

                        width: 52,
                        height: 52,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: const Color(0xFFE0B24D),
                            width: 2,
                          ),
                        ),

                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/gm_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(

                        child: Text(

                          "GM University",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      // Profile image
                      ClipOval(
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // MAIN PROFILE CARD
                Container(

                  width: 250,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(35),

                    gradient: const LinearGradient(

                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [

                        Color(0xFFE0B24D),
                        Color(0xFF6F0F18),
                      ],
                    ),
                  ),

                  child: Column(

                    children: [

                      ClipOval(
                        child: Image.asset(
                          "assets/images/profile.png",
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(

                        student.name.toUpperCase(),

                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PROFILE DETAILS
                _buildInfoCard(
                  Icons.badge,
                  "USN",
                  student.usn,
                ),

                _buildInfoCard(
                  Icons.school,
                  "Discipline",
                  student.branch,
                ),

                _buildInfoCard(
                  Icons.work,
                  "Course",
                  student.course,
                ),

                _buildInfoCard(
                  Icons.groups,
                  "Section",
                  student.section,
                ),

                _buildInfoCard(
                  Icons.water_drop,
                  "Blood Group",
                  student.bloodGroup,
                ),

                _buildInfoCard(
                  Icons.location_on,
                  "Address",
                  student.address,
                ),

                _buildInfoCard(
                  Icons.phone,
                  "Emergency Contact",
                  student.emergencyContact,
                ),

                _buildInfoCard(
                  Icons.email,
                  "Email",
                  student.email,
                ),

                _buildInfoCard(
                  Icons.person,
                  "Mentor",
                  student.mentorEmail,
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
  ) {

    return Container(

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: const Color(0xFFE0B24D),
            size: 30,
          ),

          const SizedBox(width: 18),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  value,

                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}