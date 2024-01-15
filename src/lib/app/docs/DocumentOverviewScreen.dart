import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentTypeDisplayable.dart';
import '../../models/documents/Document.dart';

class DocumentOverviewScreen extends StatefulWidget {
  const DocumentOverviewScreen({super.key});

  @override
  State<DocumentOverviewScreen> createState() => DocumentOverviewScreenState();
}

class DocumentOverviewScreenState extends State<DocumentOverviewScreen> {
  TextEditingController summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Document document =
    ModalRoute.of(context)!.settings.arguments as Document;
    summaryController.text = document.summary;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 10,
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 120,
            left: 28,
            child: Text(
              "Pregled dokumenta",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          Positioned(
            top: 164,
            left: 28,
            right: 28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
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
                                "Dokument ID: ${document.id.toString()}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              DocumentTypeDisplayable(documentType: document.documentType),
                            ],
                          ),
                          Text(
                            "Stvoren: ${document.scanTime}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(
                          Icons.text_snippet_outlined,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    child: TextField(
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      onChanged: (value) => {document.summary = value},
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: summaryController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
