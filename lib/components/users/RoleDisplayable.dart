import 'package:flutter/material.dart';
import '../../models/Role.dart';

class RoleDisplayable extends StatelessWidget {
  final Role role;
  const RoleDisplayable({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(role.name),
    );
  }
}