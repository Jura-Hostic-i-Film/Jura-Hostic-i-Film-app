import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  List<StatefulWidget> pageList = [

  ];

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Blank home screen",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 50,
                  child: const Center(child: Text("Logout", style: TextStyle(color: Colors.white))),
                ),
                onTap: () async => {
                  await apiServiceProvider.logoutUser(),
                  Navigator.pushReplacementNamed(context, '/auth/login')
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}