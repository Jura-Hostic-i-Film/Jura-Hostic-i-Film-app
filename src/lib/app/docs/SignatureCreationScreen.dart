import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentTypeDisplayable.dart';
import 'package:jura_hostic_i_film_app/components/users/ParticipantDisplayable.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/buttons/AsyncButton.dart';
import '../../models/signatures/Signature.dart';
import '../../util/LoadingDialog.dart';

class SignatureCreationScreen extends StatefulWidget {
  const SignatureCreationScreen({super.key});

  @override
  State<SignatureCreationScreen> createState() => SignatureCreationScreenState();
}

class SignatureCreationScreenState extends State<SignatureCreationScreen> {

  @override
  Widget build(BuildContext context) {
    final Signature signatureDocument =
    ModalRoute.of(context)!.settings.arguments as Signature;

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
              "Potpisivanje",
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
                                "Dokument ID: ${signatureDocument.document.id.toString()}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              DocumentTypeDisplayable(documentType: signatureDocument.document.documentType),
                            ],
                          ),
                          Text(
                            "Stvoren: ${signatureDocument.document.scanTime}",
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
                  child: ParticipantDisplayable(role: "Skenirao:", user: signatureDocument.document.owner),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ParticipantDisplayable(role: "Zatražio potpis:", user: signatureDocument.signed),
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
                      signatureDocument.document.summary,
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
                    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: false);
                    LoadingDialog.useLoadingDialog<Signature?, String>(context, apiServiceProvider.signDocument(signatureDocument.document.id), "Dokument je uspješno potpisan!", "Došlo je do pogreške!", () => Navigator.pop(context), () {});
                  },
                  content: const Center(
                    child: Text(
                      "Potpiši",
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
