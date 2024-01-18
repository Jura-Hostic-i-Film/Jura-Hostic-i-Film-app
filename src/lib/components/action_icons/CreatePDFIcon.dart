import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/models/documents/Document.dart';

class CreatePDFIcon extends StatelessWidget {
  final Document document;
  const CreatePDFIcon({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, "/docs/PDF",
          arguments: document),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.text_snippet_outlined,
          size: 28,
        ),
      ),
    );
  }
}
