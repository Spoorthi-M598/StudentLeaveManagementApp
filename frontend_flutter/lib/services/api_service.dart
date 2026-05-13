import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<bool> applyLeave({
    required int studentId,
    required String reason,
  }) async {

    final response = await http.post(
      Uri.parse("$baseUrl/apply-leave"),

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