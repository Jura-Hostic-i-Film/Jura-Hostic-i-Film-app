import 'dart:io';

import 'package:flutter/material.dart';
import '../../DTOs/DocumentDTO.dart';

class DocumentDisplayable extends StatefulWidget {
  final DocumentDTO document;
  const DocumentDisplayable({required this.document, super.key});

  @override
  State<DocumentDisplayable> createState() => DocumentDisplayableState();
}

class DocumentDisplayableState extends State<DocumentDisplayable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 10),
          padding: const EdgeInsetsDirectional.only(top: 10),
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: CircleAvatar(
                        backgroundImage:
                            FileImage(File(widget.document.imageFile.path)),
                        radius: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Text(
                          style: const TextStyle(fontSize: 17),
                          widget.document.imageFile.name
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Container(
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
