import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jura_hostic_i_film_app/util/local_storage/LocalStorageManager.dart';
import '../DTOs/LoginDTO.dart';
import '../DTOs/RegisterDTO.dart';
import '../constants.dart';
import '../models/User.dart';
import 'ApiService.dart';

class ApiServiceProvider extends ChangeNotifier {
  final String root = Constants.baseUrl;
  String? token;

  ApiServiceProvider(this.token);

  Future<bool> authUser(LoginDTO user) async {
      String? responseToken = await ApiService.usersLogin(user);
      print(responseToken);
      if (responseToken != null) {
        token = responseToken;
        notifyListeners();
        return await LocalStorageManager.writePair('token', token, true);
      }
      return false;
  }

  Future<bool> createUser(RegisterDTO user) async {
    User? responseUser = await ApiService.usersRegister(user, token);

    if (responseUser != null) {
      return await LocalStorageManager.writePair('user', jsonEncode(responseUser), false);
    }
    return false;
  }

  Future<bool> logoutUser() async {
    token = null;
    notifyListeners();
    return await LocalStorageManager.clearStorage();
  }
}