import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:jura_hostic_i_film_app/local_storage/storage_manager.dart';
import '../constants.dart';

class DatabaseProvider extends ChangeNotifier {
  final String root = Constants.baseUrl;
  late String token;

  DatabaseProvider(token);

  Future<bool> loginUser(
      String username,
      String password) async {
    var url = Uri.https(root, "/users/login");
    Response response;

    response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      token = jsonDecode(response.body)['token'];
      StorageManager.writePair('token', token, true);
      return true;
    } else {
      return false;
    }
  }
}