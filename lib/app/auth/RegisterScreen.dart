import 'package:flutter/material.dart';

import '../../DTOs/RegisterDTO.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  RegisterDTO registerUser = RegisterDTO(
    email: "",
    username: "",
    firstName: "",
    lastName: "",
    password: "",
  );

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: () => {Navigator.pushReplacementNamed(context, '/auth/login')},
              child: const SizedBox(
                width: 100,
                height: 50,
                child: Center(
                  child: Text(
                    "Login",
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
                          onChanged: (value) => {registerUser.email = value},
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          onChanged: (value) => {registerUser.username = value},
                          decoration: const InputDecoration(
                            hintText: "Username",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          onChanged: (value) => {registerUser.firstName = value},
                          decoration: const InputDecoration(
                            hintText: "First Name",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          onChanged: (value) => {registerUser.lastName = value},
                          decoration: const InputDecoration(
                            hintText: "Last Name",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          children: [
                            TextField(
                              onChanged: (value) => {registerUser.password = value},
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
                          child: const Center(child: Text("Register", style: TextStyle(color: Colors.white))),
                        ),
                        onTap: () => {},
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