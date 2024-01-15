import 'package:flutter/material.dart';
import '../../models/documents/Document.dart';

class ReviseIcon extends StatelessWidget {
  final Document document;
  const ReviseIcon({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, "/docs/revision",
          arguments: document),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.edit_note_outlined,
          size: 28,
        ),
      ),
    );
  }
}