import 'package:flutter/material.dart';

class DocumentApprovalButton extends StatelessWidget {
  final String displayedText;
  final IconData icon;
  final Color color;
  final Function onTap;

  const DocumentApprovalButton(
      {required this.displayedText, required this.onTap, super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton.icon(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        icon: Icon(
          icon,
          size: 40
        ),
        label: Text(
          displayedText,
          style: const TextStyle(
            fontSize: 25
          ),
        ),
      ),
    );
  }

}