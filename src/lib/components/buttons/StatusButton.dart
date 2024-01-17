import 'package:flutter/material.dart';

import '../../models/documents/DocumentStatus.dart';

class StatusButton extends StatelessWidget {
  final DocumentStatus? status;
  final Function onTap;
  final double fontSize;
  const StatusButton({required this.status, required this.onTap, super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: UnconstrainedBox(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: fontSize * (4/14)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(fontSize * (20/14)),
            border: Border.all(
              color: status?.displayColor() ?? Colors.black,
              width: 2,
            ),
            color: status?.displayColor() ?? Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: fontSize * (12/14)),
                child: Text(
                  status?.displayName() ?? 'Status',
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
                  Icons.arrow_drop_down_sharp,
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