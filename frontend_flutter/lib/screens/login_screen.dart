import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController usnController =
      TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    String usn =
        usnController.text.trim();

    // ✅ Check empty USN
    if (usn.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text("Enter USN"),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      // ✅ API CALL
      final response = await http.post(

        Uri.parse(
          "http://10.0.2.2/student_api/login.php",
        ),

        body: {
          "usn": usn,
        },
      );

      // ✅ Decode response
      final data =
          jsonDecode(response.body);

      // ✅ Login success
      if (data["success"] == true) {

        Navigator.pushReplacementNamed(

          context,

          "/home",

          arguments: {

            "student_name":
                data["student_name"],

            "usn":
                data["usn"],

            "department":
                data["department"],

            "current_sem":
                data["current_sem"],

            "section":
                data["section"],

            "mentor":
                data["mentor"],
          },
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(
            content:
                Text(data["message"]),
          ),
        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
              Text("Error: $e"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {

    usnController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF7E7B6),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding:
                const EdgeInsets.all(25),

            child: Column(

              children: [

                const SizedBox(height: 50),

                CircleAvatar(

                  radius: 50,

                  backgroundColor:
                      Colors.brown.shade200,

                  child: const Icon(

                    Icons.school,

                    size: 50,

                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(

                  "GM UNIVERSITY",

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight:
                        FontWeight.bold,

                    color: Colors.brown,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(

                  "LEAVE MANAGEMENT SYSTEM",

                  style: TextStyle(

                    fontSize: 16,

                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 50),

                // ✅ USN FIELD
                TextField(

                  controller:
                      usnController,

                  decoration:
                      InputDecoration(

                    hintText:
                        "Enter USN",

                    filled: true,

                    fillColor:
                        Colors.white,

                    prefixIcon:
                        const Icon(
                      Icons.person,
                    ),

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(
                              15),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // ✅ LOGIN BUTTON
                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    onPressed:
                        isLoading
                            ? null
                            : login,

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor:
                          Colors.brown,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),

                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                                color:
                                    Colors.white,
                              )
                            : const Text(

                                "Login",

                                style:
                                    TextStyle(

                                  fontSize: 20,

                                  color:
                                      Colors.white,
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}