import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class FacultyService {

  static Future<List<dynamic>>
      getAttendance() async {

    final response =
        await http.get(

      ApiService.buildUri("/faculty/attendance"),
    );

    return jsonDecode(
      response.body,
    );
  }
}