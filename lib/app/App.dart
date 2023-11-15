import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/UserProvider.dart';
import 'package:jura_hostic_i_film_app/app/auth/RegisterScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/MainScreen.dart';
import 'package:provider/provider.dart';
import '../backend_connection/ApiServiceProvider.dart';
import '../constants.dart';
import '../models/User.dart';
import 'auth/LoginScreen.dart';

class App extends StatelessWidget {
  final String? token;
  final User? user;

  const App({
    super.key,
    required this.token,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiServiceProvider(token)),
        ChangeNotifierProvider(create: (context) => UserProvider(user)),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: Constants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/auth/login': (context) => const LoginScreen(),
            '/auth/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(),
          },
          initialRoute: token == null ? '/auth/login' : '/home',
        );
      },
    );
  }
}