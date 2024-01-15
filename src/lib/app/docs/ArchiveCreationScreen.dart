import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentTypeDisplayable.dart';
import 'package:jura_hostic_i_film_app/components/users/ParticipantDisplayable.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/buttons/AsyncButton.dart';
import '../../models/audits/Audit.dart';
import '../../models/documents/Document.dart';

class ArchiveCreationScreen extends StatefulWidget {
  const ArchiveCreationScreen({super.key});

  @override
  State<ArchiveCreationScreen> createState() => ArchiveCreationScreenState();
}

class ArchiveCreationScreenState extends State<ArchiveCreationScreen> {

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider =
    Provider.of<ApiServiceProvider>(context, listen: false);

    final Audit auditedDocument =
    ModalRoute.of(context)!.settings.arguments as Audit;

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
              "Arhiviranje",
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
                  padding: const EdgeInsets.only(bottom: 12),
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
                                "Dokument ID: ${auditedDocument.document.id.toString()}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              DocumentTypeDisplayable(documentType: auditedDocument.document.documentType),
                            ],
                          ),
                          Text(
                            "Stvoren: ${auditedDocument.document.scanTime}",
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ParticipantDisplayable(role: "Skenirao:", user: auditedDocument.document.owner),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ParticipantDisplayable(role: "Revidirao:", user: auditedDocument.audited),
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
                      auditedDocument.document.summary,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AsyncButton(
                  onTap: () async {
                    Navigator.pop(context);
                    //if (await apiServiceProvider.authUser(loginUser) && mounted) Navigator.pushReplacementNamed(context, '/home');
                  },
                  content: const Center(
                    child: Text(
                      "Zatraži potpis",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(height: 10),
                AsyncButton(
                  onTap: () async {
                    Navigator.pop(context);
                    //if (await apiServiceProvider.authUser(loginUser) && mounted) Navigator.pushReplacementNamed(context, '/home');
                  },
                  content: const Center(
                    child: Text(
                      "Dodaj u arhivu",
                      style: TextStyle(color: Colors.white),
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