import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AddButton.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/users/AddedRoleDisplayable.dart';
import '../../models/RegisterState.dart';
import '../../models/Role.dart';

class RegisterScreen extends StatefulWidget {
  final bool registerFirstUser;
  const RegisterScreen({ required this.registerFirstUser, super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey dropdownKey = GlobalKey();

  RegisterState registerUser = RegisterState();

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
    if (widget.registerFirstUser) {
      registerUser.roles = [Role.admin];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          widget.registerFirstUser ?
          Container() :
          Positioned(
            top: 60,
            left: 10,
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
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
          Positioned(
            top: 120,
            left: 28,
            child: Text(
              widget.registerFirstUser ? 'Administrator' : 'Novi korisnik',
              textAlign: TextAlign.start,
              style: const TextStyle(
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
                            'Elektronička adresa',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) => {registerUser.email = value},
                            decoration: const InputDecoration(
                              hintText: "Unesite adresu elektroničke pošte",
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
                            'Naziv računa',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) => {registerUser.username = value},
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
                            'Osobni podaci',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  onChanged: (value) => {registerUser.firstName = value},
                                  decoration: const InputDecoration(
                                    hintText: "Unesite ime",
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 32,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  onChanged: (value) => {registerUser.lastName = value},
                                  decoration: const InputDecoration(
                                    hintText: "Unesite prezime",
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
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
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Stack(
                                  children: [
                                    TextField(
                                      onChanged: (value) => {registerUser.password = value},
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
                              ),
                              const SizedBox(
                                width: 32,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    onChanged: (value) => {registerUser.passwordVerify = value},
                                    decoration: const InputDecoration(
                                      hintText: "Potvrdite lozinku",
                                    ),
                                    obscureText: true,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    widget.registerFirstUser ?
                    Container() :
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Uloge',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 8.0),
                            constraints: const BoxConstraints(
                              maxHeight: 120,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 8,
                                children: registerUser.roles.map<Widget>((role) =>
                                    AddedRoleDisplayable(
                                      role: role,
                                      onTap: () {
                                        setState(() {
                                          registerUser.roles.remove(role);
                                        });
                                      },
                                      fontSize: 14,
                                    ))
                                    .followedBy(Role.getApplicable(registerUser.roles).isNotEmpty ?
                                    [
                                      Stack(
                                        children: [
                                          AddButton(
                                            displayedText: 'Dodaj ulogu',
                                            onTap: () {},
                                            fontSize: 14,
                                          ),
                                          Positioned.fill(
                                            child: Theme(
                                              data: ThemeData(
                                                splashColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                              ),
                                              child: DropdownButton<Role>(
                                                isExpanded: true,
                                                iconSize: 0,
                                                underline: const SizedBox(),
                                                key: dropdownKey,
                                                items: Role.getApplicable(registerUser.roles).map((role) =>
                                                    DropdownMenuItem(
                                                      value: role,
                                                      child: Text(
                                                        role.displayName(),
                                                      ),
                                                    )).toList(),
                                                onChanged: (Role? value) {
                                                  if (value != null && !registerUser.roles.contains(value)) {
                                                    setState(() {
                                                      registerUser.roles.add(value);
                                                    });
                                                  }
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ] : [])
                                    .toList(),
                              ),
                            ),
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
                onTap: widget.registerFirstUser ?
                    () async {
                  if (await apiServiceProvider.createStartingUser(registerUser.toRegisterDTO()) && mounted) Navigator.pushReplacementNamed(context, '/home');
                } :
                    () async {
                  if (await apiServiceProvider.createUser(registerUser.toRegisterDTO()) && mounted) Navigator.pop(context);
                },
                content: Center(
                  child: Text(
                    widget.registerFirstUser ? 'Registriraj administratora' : 'Registriraj novog korisnika',
                    style: const TextStyle(
                        color: Colors.white
                    ),
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