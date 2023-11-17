import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Text(
            'Povijest (TODO)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
            ),
          ),
        ),
    );
  }
}