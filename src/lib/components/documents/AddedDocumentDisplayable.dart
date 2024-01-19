import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentTypeDisplayable.dart';
import '../../DTOs/DocumentDTO.dart';

class AddedDocumentDisplayable extends StatefulWidget {
  final DocumentDTO document;

  const AddedDocumentDisplayable({required this.document, super.key});

  @override
  State<AddedDocumentDisplayable> createState() =>
      AddedDocumentDisplayableState();
}

class AddedDocumentDisplayableState extends State<AddedDocumentDisplayable> {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.document.imageFile.name,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.clip,
                          ),
                          const SizedBox(height: 12),
                          widget.document.processedDocument != null
                              ? DocumentTypeDisplayable(
                              documentType: widget
                                  .document.processedDocument!.documentType)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: CircleAvatar(
                        backgroundImage: FileImage(File(widget.document.imageFile.path)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: widget.document.processedDocument != null
                            ? openReview
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: const Icon(Icons.file_open_outlined, color: Colors.white, size: 32),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(color: getBarColor()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openReview() {
    Navigator.pushNamed(context, '/docs/review', arguments: widget.document).then((approved) async {
      setState(() {
        widget.document.approved = approved as bool;
      });
    });
  }

  Color getBarColor() {
    if (widget.document.processedDocument == null) {
      return Colors.grey;
    }
    return widget.document.approved ? Colors.green : Colors.red;
  }
}
