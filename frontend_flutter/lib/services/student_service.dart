import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

import '../models/student_model.dart';

class StudentService {

  // Student Profile
  static Future<Student>
      getStudent() async {

    final response =
        await http.get(

      ApiService.buildUri("/student/1"),
    );

    final data =
        jsonDecode(
            response.body);

    return Student.fromJson(
        data);
  }


  // Attendance
  static Future<List<dynamic>>
      getAttendancePercentage() async {

    final response =
        await http.get(

      ApiService.buildUri("/attendance/percentage/1"),
    );

    return jsonDecode(
      response.body,
    );
  }
}