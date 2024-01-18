import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jura_hostic_i_film_app/util/local_storage/LocalStorageManager.dart';
import 'app/App.dart';

void main(List<String>? args) async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token;
  if (args == null || !args.contains('test_reset')) {
    token = await LocalStorageManager.read('token');
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
      App(
        token: token,
      )
  );
}
