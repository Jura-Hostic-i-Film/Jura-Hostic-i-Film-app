import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/models/User.dart';
import 'RoleDisplayable.dart';

class ParticipantDisplayable extends StatelessWidget {
  final String role;
  final User user;
  const ParticipantDisplayable({required this.role, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            role,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    ' · ',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: user.roles.map((role) => RoleDisplayable(role: role)).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }}