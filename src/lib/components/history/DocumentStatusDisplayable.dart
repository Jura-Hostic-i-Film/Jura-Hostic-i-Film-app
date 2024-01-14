import 'package:flutter/material.dart';
import '../../models/documents/DocumentStatus.dart';

class DocumentStatusDisplayable extends StatelessWidget {
  final DocumentStatus documentStatus;
  const DocumentStatusDisplayable({required this.documentStatus, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: documentStatus.displayColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        documentStatus.displayName(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}