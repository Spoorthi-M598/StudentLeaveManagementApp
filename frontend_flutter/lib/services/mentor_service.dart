import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class MentorService {

  static Future<List<dynamic>>
      getLeaves() async {

    final response =
        await http.get(
      ApiService.buildUri("/mentor/leaves"),
    );

    return jsonDecode(
      response.body,
    );
  }


  static Future approveLeave(
      int leaveId) async {

    await http.put(
      ApiService.buildUri("/mentor/approve/$leaveId"),
    );
  }


  static Future rejectLeave(
      int leaveId) async {

    await http.put(
      ApiService.buildUri("/mentor/reject/$leaveId"),
    );
  }
}