import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:5000";
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return "http://10.0.2.2:5000";
      default:
        return "http://localhost:5000";
    }
  }

  static Uri buildUri(String path) => Uri.parse("$baseUrl$path");

  static Future<bool> applyLeave({
    required int studentId,
    required String reason,
  }) async {

    final response = await http.post(
      buildUri("/apply-leave"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({
        "student_id": studentId,
        "reason": reason,
      }),
    );

    return response.statusCode == 200;
  }
}