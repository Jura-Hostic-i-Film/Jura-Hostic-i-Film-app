import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/util/local_storage/LocalStorageManager.dart';
import 'app/App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await LocalStorageManager.read('token');

  runApp(
      App(
        token: token,
      )
  );
}
