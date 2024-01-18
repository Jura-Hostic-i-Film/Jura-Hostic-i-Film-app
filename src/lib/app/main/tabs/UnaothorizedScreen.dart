import 'package:flutter/material.dart';

class UnauthorizedScreen extends StatelessWidget {
  const UnauthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text(
          'Nemate nikakve ovlasti.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 42,
          ),
        ),
      ),
    );
  }
}