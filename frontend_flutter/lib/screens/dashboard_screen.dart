import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF8F3F3),

      body: SingleChildScrollView(

        child: Column(

          children: [

            // TOP HEADER
            Container(

              padding: const EdgeInsets.only(
                top: 45,
                left: 16,
                right: 16,
                bottom: 20,
              ),

              color: const Color(0xFF6F0F18),

              child: Row(

                children: [

                  // University Logo
                  Container(

                    width: 50,
                    height: 50,

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

                  // Profile Picture
                  ClipOval(
                    child: Image.asset(
                      "assets/images/profile.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // WELCOME CARD
            Container(

              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(

                borderRadius:
                    BorderRadius.circular(28),

                gradient: const LinearGradient(

                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  colors: [

                    Color(0xFFE0B24D),
                    Color(0xFF6F0F18),
                  ],
                ),
              ),

              child: const Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    "Welcome Back",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(

                    "TASMIYA KHANUM",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(

                    "CSE • Semester 2",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // QUICK ACTIONS TITLE
            const Padding(

              padding:
                  EdgeInsets.symmetric(
                      horizontal: 16),

              child: Align(

                alignment:
                    Alignment.centerLeft,

                child: Text(

                  "Quick Actions",

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ACTION BUTTONS
            Padding(

              padding:
                  const EdgeInsets.symmetric(
                      horizontal: 16),

              child: GridView.count(

                crossAxisCount: 2,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                mainAxisSpacing: 16,
                crossAxisSpacing: 16,

                childAspectRatio: 1.2,

                children: [

                  _buildActionCard(
                    Icons.edit_note,
                    "Apply Leave",
                  ),

                  _buildActionCard(
                    Icons.bar_chart,
                    "Attendance",
                  ),

                  _buildActionCard(
                    Icons.history,
                    "Leave History",
                  ),

                  _buildActionCard(
                    Icons.person,
                    "Profile",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ATTENDANCE CARD
            Container(

              margin:
                  const EdgeInsets.all(16),

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        20),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),

              child: Row(

                children: [

                  const Icon(
                    Icons.school,
                    color:
                        Color(0xFFE0B24D),
                    size: 35,
                  ),

                  const SizedBox(width: 16),

                  const Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          "Attendance",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Current attendance status",
                        ),
                      ],
                    ),
                  ),

                  Container(

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.green,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  12),
                    ),

                    child: const Text(

                      "82%",

                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildActionCard(
    IconData icon,
    String title,
  ) {

    return Container(

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

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            color:
                const Color(0xFFE0B24D),
            size: 34,
          ),

          const SizedBox(height: 12),

          Text(

            title,

            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}