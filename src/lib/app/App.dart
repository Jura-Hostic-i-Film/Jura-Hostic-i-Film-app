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

  Future<StartingState> getStartingState(ApiServiceProvider apiServiceProvider) async {
    if (!await apiServiceProvider.checkAdmin()) {
      return StartingState.noAdmin;
    } else if (!await apiServiceProvider.getCurrentUser()) {
      return StartingState.noUser;
    }
    return StartingState.authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiServiceProvider(token)),
      ],
      builder: (context, _) {
        ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);

        return FutureBuilder(
          future: getStartingState(apiServiceProvider),
          builder: (BuildContext context, AsyncSnapshot<StartingState> snapshot) {
            return snapshot.hasData ? MaterialApp(
              title: Constants.appName,
              theme: ThemeData(
                primarySwatch: Colors.grey,
              ),
              routes: {
                '/auth/login': (context) => const LoginScreen(logoutFirst: false),
                '/auth/register': (context) => const RegisterScreen(registerFirstUser: true),
                '/auth/logout': (context) => const LoginScreen(logoutFirst: true),
                '/users/register': (context) => const RegisterScreen(registerFirstUser: false),
                '/home': (context) => const HomeScreen(),
              },
              initialRoute:
                snapshot.requireData == StartingState.noAdmin ? '/auth/register' :
                snapshot.requireData == StartingState.noUser ? '/auth/login' :
                '/home',
            ) : const LoadingModal();
          }
        );
      },
    );
  }
}

enum StartingState {
  noAdmin,
  noUser,
  authenticated,
}