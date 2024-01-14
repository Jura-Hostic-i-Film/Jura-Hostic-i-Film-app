import 'package:flutter/material.dart';
import '../../models/documents/DocumentType.dart';

class DocumentTypeDisplayable extends StatelessWidget {
  final DocumentType documentType;
  const DocumentTypeDisplayable({required this.documentType, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: documentType.displayColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        documentType.displayName(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}