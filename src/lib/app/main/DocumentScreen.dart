import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jura_hostic_i_film_app/DTOs/DocumentDTO.dart';
import 'package:provider/provider.dart';

import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/documents/DocumentDisplayable.dart';
import '../../components/loading/LoadingModal.dart';
import '../../models/documents/Document.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => DocumentScreenState();
}

class DocumentScreenState extends State<DocumentScreen> {
  bool currentlyLoading = false;
  List<DocumentDTO> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child:
                  !currentlyLoading ? Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
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
                                    child: DocumentDisplayable(document: document),
                                  ),
                                )).values.toList()
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : const LoadingModal()
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton.icon(
                onPressed: /*selectedFiles.isNotEmpty ? processFiles : null, // */ () { addButtonAction(context); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                icon: const Icon(
                    Icons.adf_scanner,
                    size: 40
                ),
                label: const Text(
                  "Process files",
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              )
            )
          ],
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
            content: Text("Can't import more than 50 images at the time!"),
          ),
        );
      }
      return;
    }

    setState(() {
      selectedFiles.addAll(pickedDocuments);
    });
  }

  void processFiles() async {
    // TODO
    return;
  }
}
