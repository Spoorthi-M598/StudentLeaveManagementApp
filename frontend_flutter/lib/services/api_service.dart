import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<bool> applyLeave({
    required String leaveType,
    required String startDate,
    required String endDate,
    required int days,
    required String reason,
  }) async {

    final response = await http.post(
      Uri.parse("$baseUrl/leave/apply"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({
        "leaveType": leaveType,
        "startDate": startDate,
        "endDate": endDate,
        "days": days,
        "reason": reason,
      }),
    );

    return response.statusCode == 200;
  }
}