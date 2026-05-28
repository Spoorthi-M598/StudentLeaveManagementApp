import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AttendanceService {

  static Future<String>
      markAttendance({

    required String studentId,
    required String subject,
    required String status,
  }) async {

    final response =
        await http.post(

      ApiService.buildUri("/attendance/mark"),

      headers: {
        "Content-Type":
            "application/json",
      },

      body: jsonEncode({

        "student_id":
            int.parse(studentId),

        "subject":
            subject,

        "date":
            DateTime.now()
                .toString(),

        "status":
            status,
      }),
    );

    final data =
        jsonDecode(response.body);

    return data["message"];
  }
}