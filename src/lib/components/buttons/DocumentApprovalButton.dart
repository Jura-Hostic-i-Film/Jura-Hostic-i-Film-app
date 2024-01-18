import 'package:flutter/material.dart';

class DocumentApprovalButton extends StatelessWidget {
  final String displayedText;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final Function onTap;

  const DocumentApprovalButton(
      {required this.displayedText, required this.onTap, super.key, required this.backgroundColor, required this.foregroundColor, required this.borderColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: foregroundColor,
              ),
              const SizedBox(width: 6),
              Text(
                displayedText,
                style: TextStyle(
                    fontSize: 18,
                    color: foregroundColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}