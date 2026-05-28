import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService {

  static Future<String> signup({
    required String email,
    required String password,
    required String role,
  }) async {

    final response =
        await http.post(

      ApiService.buildUri("/auth/signup"),

      headers: {
        "Content-Type":
            "application/json",
      },

      body: jsonEncode({
        "email": email,
        "password": password,
        "role": role,
      }),
    );

    final data =
        jsonDecode(
            response.body);

    return data["message"];
  }


  static Future<String> login({
    required String email,
    required String password,
  }) async {

    final response =
        await http.post(

      ApiService.buildUri("/auth/login"),

      headers: {
        "Content-Type":
            "application/json",
      },

      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data =
        jsonDecode(
            response.body);

    if (response.statusCode ==
        200) {

      return data["role"];
    }

    throw Exception(
        data["error"]);
  }
}