import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static Future<bool> writePair(key, value, secure) async {
    if (secure) {
      const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
      await secureStorage.write(key: jsonEncode(key), value: jsonEncode(value));
      return true;
    } else {
      final storage = await SharedPreferences.getInstance();
      return await storage.setString(jsonEncode(key), jsonEncode(value));
    }
  }

  static Future<dynamic> read(key) async {
    String? result;

    final storage = await SharedPreferences.getInstance();

    if (storage.containsKey(jsonEncode(key))) {
      result = storage.getString(jsonEncode(key));
    } else {
      const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
      result = await secureStorage.read(key: jsonEncode(key));
    }

    return result != null ? jsonDecode(result) : null;
  }

  static Future<bool> clearPair(key) async {
    final storage = await SharedPreferences.getInstance();

    if (storage.containsKey(jsonEncode(key))) {
      return await storage.remove(jsonEncode(key));
    }

    const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    secureStorage.delete(key: jsonEncode(key));
    return true;
  }

  static Future<bool> clearStorage() async {
    const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final storage = await SharedPreferences.getInstance();

    secureStorage.deleteAll();

    return await storage.clear();
  }
}