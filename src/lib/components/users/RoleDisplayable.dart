import 'package:flutter/material.dart';
import '../../models/Role.dart';

class RoleDisplayable extends StatelessWidget {
  final Role role;
  const RoleDisplayable({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: role.displayColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        role.displayName(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}