import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/documents/Document.dart';

class OverviewIcon extends StatelessWidget {
  final Document document;
  const OverviewIcon({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, "/docs/overview",
          arguments: document),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.file_open,
          size: 28,
        ),
      ),
    );
  }

}