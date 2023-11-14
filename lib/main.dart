import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/local_storage/storage_manager.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'database/database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token = await StorageManager.read('token', true);

  runApp(
      MyApp(
        token: token,
      )
  );
}

class MyApp extends StatelessWidget {
  final String token;

  const MyApp({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseProvider(token)),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: Constants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseProvider databaseProvider;

  void _incrementCounter() {
    setState(() {
      databaseProvider.loginUser('admin', 'admin');
    });
  }

  @override
  Widget build(BuildContext context) {
    databaseProvider = Provider.of<DatabaseProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              databaseProvider.token,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Send',
        child: const Icon(Icons.add),
      ),
    );
  }
}
