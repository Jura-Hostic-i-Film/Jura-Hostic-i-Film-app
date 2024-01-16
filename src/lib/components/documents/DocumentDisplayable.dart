import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import '../../DTOs/DocumentDTO.dart';
import '../../app/main/documents/DocumentReviewScreen.dart';
import '../../models/documents/Document.dart';

class DocumentDisplayable extends StatefulWidget {
  final DocumentDTO document;
  final ApiServiceProvider apiProvider;

  const DocumentDisplayable({required this.document, super.key, required this.apiProvider});

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
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        getDocType()
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: widget.document.processedDocument != null ? openReview : null,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.teal,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: getBarColor()
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openReview(){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => DocumentReviewScreen(documentDTO: widget.document,))
        ).then((approved) async {
            setState(() {
              widget.document.approved = approved;
            });
    });
  }

  String getDocType(){
    if(widget.document.processedDocument == null){
      return "-";
    }
    return widget.document.processedDocument!.documentType.displayName();
  }

  Color getBarColor(){
    if(widget.document.processedDocument == null){
      return Colors.grey;
    }
    return widget.document.approved ? Colors.green : Colors.red;
  }
}
