import 'package:flutter/material.dart';

import '../../models/Role.dart';

class AddedRoleDisplayable extends StatelessWidget {
  final Role role;
  final Function onTap;
  final double fontSize;

  const AddedRoleDisplayable({required this.role, required this.onTap, super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: UnconstrainedBox(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: fontSize * (4/14) + 2, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(fontSize * (20/14)),
            color: role.displayColor(),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: fontSize * (12/14)),
                child: Text(
                  role.displayName(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: fontSize * (8/14)),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: fontSize * (20/14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}