import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import '../models/leave_model.dart';

class LeaveService {
  static Future<List<LeaveModel>>
    getHistory() async {

    final response = await http.get(
      ApiService.buildUri("/leave/history/1"),
    );

  if (response.statusCode == 200) {

    final data =
        jsonDecode(response.body);

    return List<LeaveModel>.from(
      data.map(
        (x) =>
            LeaveModel.fromJson(x),
      ),
    );
  }

  throw Exception(
      "Failed to load history");
}

  // Submit leave
  static Future<String> applyLeave({
    required String fromDate,
    required String toDate,
    required String reason,
    required String leaveType,
  }) async {

    final response = await http.post(
      ApiService.buildUri("/leave/apply"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({
        "student_id": 1,
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
        "leave_type": leaveType,
      }),
    );

    if (response.statusCode == 200) {
      final data =
          jsonDecode(response.body);

      return data["message"];
    }

    throw Exception(
      "Failed to apply leave",
    );
  }


  // Preview missed classes
  static Future<String> previewLeave({
    required String fromDate,
    required String toDate,
  }) async {

    final response = await http.post(
      ApiService.buildUri("/leave/preview"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({
        "student_id": 1,
        "from_date": fromDate,
        "to_date": toDate,
      }),
    );

    if (response.statusCode == 200) {

      final data =
          jsonDecode(response.body);

      return data["missed_classes"]
          .join("\n");
    }

    throw Exception(
      "Preview failed",
    );
  }
}