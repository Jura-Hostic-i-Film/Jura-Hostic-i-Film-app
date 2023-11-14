import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageManager {
  static Future<bool> writePair(key, value, secure) async {
    const secureStorage = FlutterSecureStorage();

    if (secure) {
      await secureStorage.write(key: jsonEncode(key), value: jsonDecode(value));
      return true;
    }
    return false;
  }

  static Future<dynamic> read(key, secure) async {
    const secureStorage = FlutterSecureStorage();
    String? result;

    if (secure) {
      result = await secureStorage.read(key: jsonEncode(key));
    }

    return result != null ? jsonDecode(result) : null;
  }
}