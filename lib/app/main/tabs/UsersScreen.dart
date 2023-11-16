import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/users/UserDisplayable.dart';
import 'package:provider/provider.dart';

import '../../../backend_connection/ApiServiceProvider.dart';
import '../../../models/User.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);

    return FutureBuilder(
        future: apiServiceProvider.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          return snapshot.hasData ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      'Novi korisnik',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/users/register');
                            },
                          ),
                        ],
                      ),
                      //margin: const EdgeInsets.only(bottom: 10),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: snapshot.requireData.map((user) => UserDisplayable(user: user)).toList()
                    ),
                  ),
                ),
              ],
            ),
          ) : const Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: CircularProgressIndicator(),
              ),
          );
        },
    );

  }
}