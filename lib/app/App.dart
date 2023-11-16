import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/app/auth/RegisterScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/MainScreen.dart';
import 'package:provider/provider.dart';
import '../backend_connection/ApiServiceProvider.dart';
import '../components/loading/LoadingModal.dart';
import '../constants.dart';
import 'auth/LoginScreen.dart';

class App extends StatelessWidget {
  final String? token;

  const App({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiServiceProvider(token)),
      ],
      builder: (context, _) {
        ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);

        return FutureBuilder(
          future: apiServiceProvider.getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return snapshot.hasData ? MaterialApp(
              title: Constants.appName,
              theme: ThemeData(
                primarySwatch: Colors.grey,
              ),
              routes: {
                '/auth/login': (context) => const LoginScreen(),
                '/auth/register': (context) => const RegisterScreen(registerFirstUser: true),
                '/users/register': (context) => const RegisterScreen(registerFirstUser: false),
                '/home': (context) => const HomeScreen(),
              },
              initialRoute: snapshot.requireData ? '/home' : '/auth/login',
            ) : const LoadingModal();
          },
        );
      },
    );
  }
}