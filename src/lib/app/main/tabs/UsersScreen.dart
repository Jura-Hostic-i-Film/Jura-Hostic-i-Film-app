import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AddButton.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
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

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: FutureBuilder(
                future: apiServiceProvider.getAllUsers(),
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  return snapshot.hasData ? Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                children: snapshot.requireData
                                    .toList()
                                    .asMap().map((i, user) => MapEntry(
                                  i,
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                          ),
                                        )
                                    ),
                                    child: UserDisplayable(user: user),
                                  ),
                                )).values.toList()
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : const LoadingModal();
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AddButton(
                            displayedText: 'Novi korisnik',
                            onTap: () => Navigator.pushNamed(context, '/users/register'),
                            fontSize: 12,
                          ),
                          GestureDetector(
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.refresh,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                            onTap: () => setState(() {}),
                          )
                        ],
                      ),
                      //margin: const EdgeInsets.only(bottom: 10),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}