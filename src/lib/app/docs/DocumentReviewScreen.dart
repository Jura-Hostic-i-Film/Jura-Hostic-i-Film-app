import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/DTOs/DocumentDTO.dart';
import 'package:jura_hostic_i_film_app/components/buttons/DocumentApprovalButton.dart';

import '../../components/history/DocumentTypeDisplayable.dart';

class DocumentReviewScreen extends StatelessWidget {
  const DocumentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DocumentDTO documentDTO = ModalRoute.of(context)!.settings.arguments as DocumentDTO;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(documentDTO.imageFile.path)),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 400,
            child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Informacije",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 4,
                            children: [
                              Wrap(
                                spacing: 12,
                                children: [
                                  Text(
                                    "Dokument ID: ${documentDTO.processedDocument!.id.toString()}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  DocumentTypeDisplayable(documentType: documentDTO.processedDocument!.documentType),
                                ],
                              ),
                              Text(
                                "Stvoren: ${documentDTO.processedDocument!.scanTime}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            documentDTO.processedDocument!.summary,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DocumentApprovalButton(
                              displayedText: "Odbij",
                              icon: Icons.close,
                              onTap: () => goBack(context, false),
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              borderColor: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: DocumentApprovalButton(
                              displayedText: "Potvrdi",
                              icon: Icons.check,
                              onTap: () => goBack(context, true),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              borderColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ]
                )
            ),
          ),
        ],
      )
    );
  }

  void goBack(BuildContext context, bool accepted){
    Navigator.pop(context, accepted);
  }
}