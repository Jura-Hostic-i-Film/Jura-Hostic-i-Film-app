import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/DTOs/DocumentDTO.dart';
import 'package:jura_hostic_i_film_app/components/buttons/DocumentApprovalButton.dart';

class DocumentReviewScreen extends StatelessWidget {
  final DocumentDTO documentDTO;

  const DocumentReviewScreen({required this.documentDTO, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(documentDTO.imageFile.path)),
                    fit: BoxFit.cover
                )
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Container(
                color: Colors.white,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Informacije",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      customTypeDivider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Vrsta:",
                              style: TextStyle(
                                fontSize: 25
                              ),
                            ),
                            Text(
                              documentDTO.processedDocument!.documentType.displayName(),
                              style: const TextStyle(
                                  fontSize: 25
                              ),
                            )
                          ],
                        ),
                      ),
                      customTypeDivider(),
                      const Text(
                        "Sažetak",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                        child: Divider(
                          height: 15,
                          thickness: 1.5,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        documentDTO.processedDocument!.summary,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ]
                  )
                )
              ),
            )
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DocumentApprovalButton(
                      color: Colors.red,
                      displayedText: "Odbij",
                      icon: Icons.cancel,
                      onTap: () => goBack(context, false),
                    ),
                    DocumentApprovalButton(
                      color: Colors.green,
                      displayedText: "Odobri",
                      icon: Icons.check,
                      onTap: () => goBack(context, true),
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      )
    );
  }

  Widget customTypeDivider(){
    return SizedBox(
      width: 350,
      child: Divider(
        height: 20,
        thickness: 1.5,
        color: documentDTO.processedDocument!.documentType.displayColor(),
      ),
    );
  }

  void goBack(BuildContext context, bool accepted){
    Navigator.pop(context, accepted);
  }
}