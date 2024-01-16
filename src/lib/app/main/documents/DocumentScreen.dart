import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jura_hostic_i_film_app/DTOs/DocumentDTO.dart';
import 'package:provider/provider.dart';

import '../../../backend_connection/ApiServiceProvider.dart';
import '../../../components/documents/DocumentDisplayable.dart';
import '../../../components/loading/LoadingModal.dart';
import '../../../models/documents/Document.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => DocumentScreenState();
}

class DocumentScreenState extends State<DocumentScreen> {
  late ApiServiceProvider apiServiceProvider;

  bool currentlyLoading = false;
  bool didDocumentProcessing = false;
  bool didDocumentSubmission = false;

  List<DocumentDTO> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      body: Center(
        child: !didDocumentSubmission ? Column(
          children: [
            Expanded(
              child: Container(
                child: !currentlyLoading ? Container(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: selectedFiles.isNotEmpty ? Column(
                              children: selectedFiles
                                  .asMap().map((i, document) => MapEntry(
                                i,
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black
                                        ),
                                      )
                                  ),
                                  child: DocumentDisplayable(document: document, apiProvider: apiServiceProvider),
                                ),
                              )).values.toList()
                          ) : const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "Trenutno nema odabranih dokumenata...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : const LoadingModal(),
              ),
            ),
            !currentlyLoading ? Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                child: Row(
                  mainAxisAlignment: didDocumentProcessing ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 250,
                      child: ElevatedButton.icon(
                        onPressed: selectedFiles.isNotEmpty ? (didDocumentProcessing ? submitFiles : processFiles) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: didDocumentProcessing ? Colors.deepOrange : Colors.blue,
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
                            didDocumentProcessing ? Icons.outgoing_mail : Icons.adf_scanner,
                            size: 40
                        ),
                        label: Text(
                          !didDocumentProcessing ? "Procesiraj" : "Zaključaj odabir",
                          style: const TextStyle(
                              fontSize: 25
                          ),
                        ),
                      )
                    ),
                    !didDocumentProcessing ? ElevatedButton(
                      onPressed: () { addButtonAction(context); },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.teal,
                      ),
                      child: const Icon(Icons.note_add, color: Colors.white),
                    ) : Container()
                  ],
                ),
              )
            ) : Container()
            ],
          ) : const SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 40,
                  ),
                  Text(
                    "Dokumenti su ažurirani!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
          ),
        ),
      );
  }

  void addButtonAction(BuildContext context) async{
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if(pickedFiles.isEmpty){
      return;
    }

    final pickedDocuments = pickedFiles
                              .map((file) => DocumentDTO(file))
                              .where((doc) => !selectedFiles.contains(doc));

    if(selectedFiles.length + pickedDocuments.length > 50) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nije moguće odabrati više od 50 slika u trenutku!"),
          ),
        );
      }
      return;
    }

    setState(() {
      selectedFiles.addAll(pickedDocuments);
    });
  }

  void submitFiles() async {
    setState(() {
      currentlyLoading = true;
    });

    for (var documentObject in selectedFiles) {
      await apiServiceProvider.approveDocument(
          documentObject.processedDocument!.id,
          documentObject.approved
      );
    }

    setState(() {
      currentlyLoading = false;
      didDocumentSubmission = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted){
        Navigator.pop(context);
    }
  }

  void processFiles() async {
    setState(() {
      currentlyLoading = true;
    });

    setState(() async {
      for (var documentObject in selectedFiles) {
        Document? processedDoc = await apiServiceProvider.createDocument(
            documentObject.imageFile.path);
        documentObject.processedDocument = processedDoc;
      }

      didDocumentProcessing = true;
      currentlyLoading = false;
    });
  }
}
