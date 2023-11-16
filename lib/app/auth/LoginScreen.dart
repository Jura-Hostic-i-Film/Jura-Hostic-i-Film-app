import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/DTOs/LoginDTO.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/buttons/AsyncButton.dart';

class LoginScreen extends StatefulWidget {
  final bool logoutFirst;
  const LoginScreen({super.key, required  this.logoutFirst});

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

  Widget loginScreenModal(BuildContext context, ApiServiceProvider apiServiceProvider) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Positioned(
            top: 120,
            left: 28,
            child: Text(
              'Prijava',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Naziv računa',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) => {loginUser.username = value},
                            decoration: const InputDecoration(
                              hintText: "Unesite naziv računa",
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Lozinka',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Stack(
                            children: [
                              TextField(
                                onChanged: (value) => {loginUser.password = value},
                                decoration: const InputDecoration(
                                  hintText: "Unesite lozinku",
                                ),
                                obscureText: obscureText,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AsyncButton(
                onTap: () async {
                  if (await apiServiceProvider.authUser(loginUser) && mounted) Navigator.pushReplacementNamed(context, '/home');
                },
                content: const Center(child: Text("Prijavi se", style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);

    return widget.logoutFirst ?
        FutureBuilder(
            future: apiServiceProvider.logoutUser(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return snapshot.hasData ?
                  loginScreenModal(context, apiServiceProvider) :
                  const LoadingModal();
            }
            ) :
        loginScreenModal(context, apiServiceProvider);
    }
}

/*

 */