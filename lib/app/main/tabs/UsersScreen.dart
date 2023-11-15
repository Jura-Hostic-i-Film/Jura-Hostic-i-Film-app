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
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return FutureBuilder(
        future: apiServiceProvider.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          return snapshot.hasData ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: snapshot.requireData.map((user) => UserDisplayable(user: user)).toList()
                //snapshot.requireData.map((user) => Text(user.username)).toList(),
              ),
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