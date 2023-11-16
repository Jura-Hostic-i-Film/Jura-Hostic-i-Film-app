import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:provider/provider.dart';

import '../../DTOs/RegisterDTO.dart';
import '../../backend_connection/ApiServiceProvider.dart';

class RegisterScreen extends StatefulWidget {
  final bool registerFirstUser;
  const RegisterScreen({ required this.registerFirstUser, super.key});

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
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          !widget.registerFirstUser ? Positioned(
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
          ) :
          Positioned(
            top: 60,
            left: 10,
            child: GestureDetector(
              onTap: () => {Navigator.pushReplacementNamed(context, '/auth/login')},
              child: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 32,
                    )
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
                width: 320,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 128,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: TextField(
                              onChanged: (value) => {registerUser.firstName = value},
                              decoration: const InputDecoration(
                                hintText: "First Name",
                              ),
                            ),
                          ),
                          Container(
                            width: 128,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: TextField(
                              onChanged: (value) => {registerUser.lastName = value},
                              decoration: const InputDecoration(
                                hintText: "Last Name",
                              ),
                            ),
                          ),
                        ],
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
                      AsyncButton(
                          onTap: widget.registerFirstUser ?
                          () async {
                            if (await apiServiceProvider.createStartingUser(registerUser) && mounted) Navigator.pushReplacementNamed(context, '/home');
                          } :
                          () async {
                            if (await apiServiceProvider.createStartingUser(registerUser) && mounted) Navigator.pop(context);
                          },
                          content: Center(
                            child: Text(
                              widget.registerFirstUser ? 'Stvori korisnika' : 'Registriraj admina',
                              style: const TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
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