import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jura_hostic_i_film_app/DTOs/DocumentDTO.dart';
import 'package:provider/provider.dart';

import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/buttons/AsyncButton.dart';
import '../../components/documents/AddedDocumentDisplayable.dart';
import '../../components/loading/LoadingModal.dart';
import '../../models/documents/Document.dart';

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
    apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: !didDocumentSubmission
            ? Column(
                children: [
                  Expanded(
                    child: Container(
                      child: !currentlyLoading
                          ? Container(
                              padding: const EdgeInsets.only(top: 60),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: selectedFiles.isNotEmpty
                                          ? Column(
                                              children: selectedFiles
                                                  .asMap()
                                                  .map((i, document) =>
                                                      MapEntry(
                                                        i,
                                                        AddedDocumentDisplayable(
                                                            document: document),
                                                      ))
                                                  .values
                                                  .toList())
                                          : const SizedBox(
                                              height: 200,
                                              child: Center(
                                                child: Text(
                                                  "Trenutno nema odabranih dokumenata.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const LoadingModal(),
                    ),
                  ),
                  !currentlyLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: didDocumentProcessing
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: AsyncButton(
                                    onTap: () async {
                                      if (selectedFiles.isNotEmpty) {
                                        if (didDocumentProcessing) {
                                          submitFiles();
                                        } else {
                                          processFiles();
                                        }
                                      }
                                    },
                                    content: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            didDocumentProcessing
                                                ? Icons.check
                                                : Icons.adf_scanner,
                                            color: didDocumentProcessing
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            !didDocumentProcessing
                                                ? "Procesiraj"
                                                : "Završi",
                                            style: TextStyle(
                                              color: didDocumentProcessing
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    backgroundColor: didDocumentProcessing
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                !didDocumentProcessing
                                    ? ElevatedButton(
                                        onPressed: () {
                                          addButtonAction(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(5),
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.white, size: 40),
                                      )
                                    : Container()
                              ],
                            ),
                          ))
                      : Container()
                ],
              )
            : const SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                      size: 40,
                    ),
                    Text(
                      "Dokumenti su ažurirani!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void addButtonAction(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isEmpty) {
      return;
    }

    final pickedDocuments = pickedFiles
        .map((file) => DocumentDTO(file))
        .where((doc) => !selectedFiles.contains(doc));

    if (selectedFiles.length + pickedDocuments.length > 50) {
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
      if (documentObject.processedDocument != null) {
        await apiServiceProvider.approveDocument(
            documentObject.processedDocument!.id, documentObject.approved);
      }
    }

    setState(() {
      currentlyLoading = false;
      didDocumentSubmission = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void processFiles() async {
    setState(() {
      currentlyLoading = true;
    });

    for (var documentObject in selectedFiles) {
      Document? processedDoc = await apiServiceProvider
          .createDocument(documentObject.imageFile.path);
      setState(() {
        documentObject.processedDocument = processedDoc;
      });
    }
    setState(() {
      didDocumentProcessing = true;
      currentlyLoading = false;
    });
  }
}
