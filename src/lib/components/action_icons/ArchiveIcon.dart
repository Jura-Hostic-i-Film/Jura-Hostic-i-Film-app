import 'package:flutter/material.dart';
import '../../models/archives/Archive.dart';

class ArchiveIcon extends StatelessWidget {
  final Archive archive;
  final Function callback;
  const ArchiveIcon({super.key, required this.archive, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, "/docs/archive",
          arguments: archive).then((value) => callback()),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.archive,
          size: 28,
        ),
      ),
    );
  }
}
