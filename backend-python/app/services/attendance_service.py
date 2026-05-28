import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentAttendanceService {

  static Future<List<dynamic>>
      getAttendancePercentage() async {

    final response =
        await http.get(

      Uri.parse(
        "http://10.0.2.2:5000/attendance/percentage/1",
      ),
    );

    return jsonDecode(
      response.body,
    );
  }
}