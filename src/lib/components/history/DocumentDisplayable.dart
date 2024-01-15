import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/action_icons/DownloadOriginalIcon.dart';
import 'package:jura_hostic_i_film_app/components/action_icons/OverviewIcon.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        OverviewIcon(document: document),
                        const SizedBox(width: 6),
                        DownloadOriginalIcon(document: document),
                      ],
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: DocumentStatusDisplayable(
                          documentStatus: document.documentStatus)),
                  const SizedBox(width: 6),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: DocumentTypeDisplayable(
                          documentType: document.documentType)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
