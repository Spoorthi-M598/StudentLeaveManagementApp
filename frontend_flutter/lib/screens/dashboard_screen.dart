import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget dashboardBox(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    String route,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },

      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
            )
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.1),

              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              title,

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              subtitle,
              textAlign: TextAlign.center,

              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // ✅ GET LOGIN DATA
    final args =
        ModalRoute.of(context)?.settings.arguments
            as Map?;

    final studentName =
        args?["student_name"] ?? "Student";

    final usn =
        args?["usn"] ?? "";

    final currentSem =
        args?["current_sem"] ?? "";

    final section =
        args?["section"] ?? "";

    final mentor =
        args?["mentor"] ?? "";

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F1EC),

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF6F4E37),

        title: const Text(
          "Dashboard",

          style: TextStyle(
            color: Colors.white,
          ),
        ),

        centerTitle: true,

        actions: const [

          Padding(
            padding: EdgeInsets.only(right: 15),

            child: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          )
        ],
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(

            children: [

              // 👤 PROFILE CARD
              Container(

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [

                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),

                child: Row(

                  children: [

                    const CircleAvatar(
                      radius: 35,

                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          // ✅ STUDENT NAME
                          Text(
                            studentName,

                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // ✅ USN
                          Text(
                            usn,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // ✅ SEM + SECTION
                          Text(
                            "CSE - Sem $currentSem - Section $section",

                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // ✅ MENTOR
                          Text(
                            "Mentor : $mentor",

                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 📊 ATTENDANCE CARD
              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.brown.shade100,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Overall Attendance",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "86%",

                          style: TextStyle(
                            fontSize: 40,
                            fontWeight:
                                FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),

                    Icon(
                      Icons.bar_chart,

                      size: 70,

                      color:
                          Colors.brown.shade400,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 📦 GRID
              GridView.count(

                crossAxisCount: 2,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                childAspectRatio: 1,

                children: [

                  dashboardBox(
                    context,
                    Icons.edit_document,
                    "Apply Leave",
                    "Request new leave",
                    const Color(0xFF6F4E37),
                    "/apply",
                  ),

                  dashboardBox(
                    context,
                    Icons.description,
                    "My Leaves",
                    "View leave history",
                    Colors.pink,
                    "/myLeaves",
                  ),

                  dashboardBox(
                    context,
                    Icons.bookmark_added,
                    "Leave Quota",
                    "View quota balance",
                    Colors.indigo,
                    "/quota",
                  ),

                  dashboardBox(
                    context,
                    Icons.verified,
                    "Attendance",
                    "View attendance",
                    Colors.green,
                    "/attendance",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚠️ WARNING
              Container(

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.orange.shade50,

                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: const Row(

                  children: [

                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Minimum 85% attendance required in each subject.",

                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}