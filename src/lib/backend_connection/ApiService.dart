import 'dart:convert';
import 'package:http/http.dart';
import 'package:jura_hostic_i_film_app/DTOs/RegisterDTO.dart';
import 'package:jura_hostic_i_film_app/util/helpers/formatToken.dart';
import 'package:jura_hostic_i_film_app/util/helpers/secureHash.dart';
import '../DTOs/LoginDTO.dart';
import '../constants.dart';
import '../models/User.dart';

class ApiService {
  static const String root = Constants.baseUrl;

  static Future<String?> usersLogin(LoginDTO user) async {
    final url = Uri.https(root, "/users/login");

    Response response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': secureHash(user.password),
      }),
    );

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body)['token'];
      return token;
    } else {
      return null;
    }
  }

  static Future<User?> usersRegister(
      RegisterDTO user,
      String token,
      ) async {
    var url = Uri.https(root, "/users/register");

    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token)
      },
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'username': user.username,
        'password': secureHash(user.password),
        'first_name': user.firstName,
        'last_name': user.lastName,
        'roles': user.roles.map((role) => role.name).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<User?> usersMe(String token) async {
    final url = Uri.https(root, "/users/me");

    Response response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<List<User>> users(String token) async {
    final url = Uri.https(root, "/users");

    Response response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': formatToken(token),
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map<User>((json) => User.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<User?> usersRegisterAdmin(RegisterDTO user) async {
    var url = Uri.https(root, "/users/register/admin");
    Response response = await post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'username': user.username,
        'password': secureHash(user.password),
        'first_name': user.firstName,
        'last_name': user.lastName,
        'roles': user.roles.map((role) => role.name).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return null;
    }
  }

  static Future<bool> usersAdminExists() async {
    final url = Uri.https(root, "/users/admin/exists");

    Response response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return false;
    }
  }
}