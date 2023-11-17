import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String displayedText;
  final Function onTap;
  final double fontSize;
  const AddButton({required this.displayedText, required this.onTap, super.key, required this.fontSize});

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
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: fontSize * (12/14)),
                child: Text(
                  displayedText,
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
                  Icons.add,
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