import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentTypeDisplayable.dart';
import 'package:provider/provider.dart';
import '../../components/action_icons/CreatePDFIcon.dart';
import '../../components/buttons/AsyncButton.dart';
import '../../components/users/ParticipantDisplayable.dart';
import '../../models/Role.dart';
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

    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);

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
                      CreatePDFIcon(document: document),
                    ],
                  ),
                ),
                document.owner.id != apiServiceProvider.currentUser?.id ? Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ParticipantDisplayable(role: "Skenirao:", user: document.owner),
                ) : const SizedBox(),
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      document.summary,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
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
