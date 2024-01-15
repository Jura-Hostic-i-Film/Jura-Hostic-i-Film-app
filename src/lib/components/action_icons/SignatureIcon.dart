import 'package:flutter/material.dart';
import '../../models/signatures/Signature.dart';

class SignatureIcon extends StatelessWidget {
  final Signature signature;
  final Function callback;
  const SignatureIcon({super.key, required this.signature, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, "/docs/signature",
          arguments: signature).then((value) => callback()),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.draw,
          size: 28,
        ),
      ),
    );
  }
}
