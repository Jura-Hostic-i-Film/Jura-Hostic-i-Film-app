import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/models/documents/Document.dart';
import 'DocumentTypeDisplayable.dart';
import 'DocumentStatusDisplayable.dart';

class DocumentDisplayable extends StatelessWidget {
  final Document document;
  const DocumentDisplayable({required this.document, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 10),
          padding: const EdgeInsetsDirectional.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Document ID: ${document.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'Stvoren: ${document.scanTime.toString().split(".")[0]}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(
                          Icons.file_open,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(
                          Icons.download,
                          size: 28,
                        ),
                      ),
                ],
              ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            //
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
                  DocumentStatusDisplayable(documentStatus: document.documentStatus)
              ),
              const SizedBox(width:6),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child:
                  DocumentTypeDisplayable(documentType: document.documentType)
              ),
              ],
          )
            ],
          ),
        ),
      ],
    );
  }}