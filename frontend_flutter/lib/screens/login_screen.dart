import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'navigation_screen.dart';
import 'mentor_screen.dart';
import 'faculty_attendance_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;
  bool hidePassword = true;

  Future login() async {

    try {

      setState(() {
        loading = true;
      });

      final role =
          await AuthService.login(
        email: emailController.text,
        password:
            passwordController.text,
      );

      if (!mounted) return;

      if (role == "student") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
               const NavigationScreen(),
          ),
        );

      } else if (role == "mentor") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const MentorScreen(),
          ),
        );

      } else if (role == "faculty") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const FacultyAttendanceScreen(),
          ),
        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

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
          const Color(0xFFF7F3F3),

      body: SingleChildScrollView(

        child: Column(

          children: [

            // TOP HEADER
            Container(

              height: 330,

              width:
                  double.infinity,

              decoration:
                  const BoxDecoration(

                color:
                    Color(
                        0xFF6D1218),

                borderRadius:
                    BorderRadius.only(

                  bottomLeft:
                      Radius.circular(
                          120),

                  bottomRight:
                      Radius.circular(
                          120),
                ),
              ),

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                children: [

                  Image.asset(
                    "assets/images/gm_logo.png",
                    height: 170,
                  ),

                  const SizedBox(
                      height: 10),

                  const Text(

                    "GM UNIVERSITY",

                    style:
                        TextStyle(

                      color:
                          Color(
                              0xFFD8A945),

                      fontSize:
                          34,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  const Text(

                    "Innovating Minds",

                    style:
                        TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          20,

                      fontStyle:
                          FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 40),

            // FORM
            Padding(

              padding:
                  const EdgeInsets
                      .symmetric(
                          horizontal:
                              28),

              child: Column(

                children: [

                  TextField(

                    controller:
                        emailController,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Username",

                      filled: true,

                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                                18),

                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  TextField(

                    controller:
                        passwordController,

                    obscureText:
                        hidePassword,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Password",

                      suffixIcon:
                          IconButton(

                        onPressed: () {

                          setState(() {

                            hidePassword =
                                !hidePassword;
                          });
                        },

                        icon: Icon(

                          hidePassword
                              ? Icons
                                  .visibility_off
                              : Icons
                                  .visibility,
                        ),
                      ),

                      filled: true,

                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                                18),

                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 50),

                  SizedBox(

                    width: 220,
                    height: 55,

                    child:
                        ElevatedButton(

                      onPressed:
                          loading
                              ? null
                              : login,

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            const Color(
                                0xFFD8A945),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  30),
                        ),
                      ),

                      child:
                          loading

                              ? const CircularProgressIndicator(
                                  color:
                                      Colors.white,
                                )

                              : const Text(

                                  "Login",

                                  style:
                                      TextStyle(

                                    color:
                                        Colors.white,

                                    fontSize:
                                        20,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}