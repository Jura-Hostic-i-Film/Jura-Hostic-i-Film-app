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
  User? currentUser;

  ApiServiceProvider(this.token);

  Future<bool> authUser(LoginDTO user) async {
      String? responseToken = await ApiService.usersLogin(user);
      if (responseToken != null) {
        token = responseToken;
        getCurrentUser();
        notifyListeners();
        return await LocalStorageManager.writePair('token', token, true);
      }
      return false;
  }

  Future<bool> createUser(RegisterDTO user) async {
    User? responseUser = await ApiService.usersRegister(user, token);

    return responseUser != null;
  }

  Future<bool> createStartingUser(RegisterDTO user) async {
    await ApiService.usersRegister(user, null);
    return await authUser(user.toLoginDTO());
  }

  Future<bool> getCurrentUser() async {
    if (token != null) {
      currentUser ??= await ApiService.usersMe(token!);
    }

    return currentUser != null;
  }

  Future<bool> logoutUser() async {
    token = null;
    currentUser = null;
    notifyListeners();
    return await LocalStorageManager.clearStorage();
  }

  Future<List<User>> getAllUsers() async {
    if (token != null) {
      return await ApiService.users(token!);
    }

    return [];
  }
}