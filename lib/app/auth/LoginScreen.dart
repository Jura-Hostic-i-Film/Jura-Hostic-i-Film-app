import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/DTOs/LoginDTO.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginDTO loginUser = LoginDTO("", "");

  bool obscureText = true;
  IconData obscureIcon = Icons.visibility_off;

  void setObscure() {
    setState(() {
      obscureText = !obscureText;
      obscureIcon = obscureText ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              top: 60,
              right: 20,
              child: GestureDetector(
                onTap: () => {Navigator.pushReplacementNamed(context, '/auth/register')},
                child: const SizedBox(
                  width: 100,
                  height: 50,
                  child: Center(
                      child: Text(
                          "Register",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                ),
              ),
          ),
          Center(
            child: UnconstrainedBox(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                padding: const EdgeInsets.all(20),
                width: 280,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          onChanged: (value) => {loginUser.username = value},
                          decoration: const InputDecoration(
                            hintText: "Username",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          children: [
                            TextField(
                              onChanged: (value) => {loginUser.password = value},
                              decoration: const InputDecoration(
                                hintText: "Password",
                              ),
                              obscureText: obscureText,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: setObscure,
                                  child: Icon(
                                    obscureIcon,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 50,
                          child: const Center(child: Text("Login", style: TextStyle(color: Colors.white))),
                        ),
                        onTap: () async => {
                          if (await apiServiceProvider.authUser(loginUser)) Navigator.pushReplacementNamed(context, '/home')
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}