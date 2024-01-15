import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:jura_hostic_i_film_app/models/audits/AuditStatus.dart';
import 'package:jura_hostic_i_film_app/models/signatures/SignatureStatus.dart';
import 'package:provider/provider.dart';

import '../../../backend_connection/ApiServiceProvider.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<DebugScreen> createState() => DebugScreenState();
}

class DebugScreenState extends State<DebugScreen> {
  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);
    if (false) apiServiceProvider.apiDocumentsTest();
    if (false) apiServiceProvider.apiAuditArchiveTest();
    if (false) apiServiceProvider.apiSignaturesTest();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.refresh,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              onTap: () => setState(() {}),
            ),
          ),
          Positioned(
            top: 0,
            right: 84,
            child: GestureDetector(
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              onTap: () async {
                Navigator.pushNamed(context, '/docs/signature', arguments: (await apiServiceProvider.getSignatures(21, SignatureStatus.pending)).first);
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 42,
            child: GestureDetector(
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.archive,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              onTap: () async {
                Navigator.pushNamed(context, '/docs/archive', arguments: (await apiServiceProvider.getAudits(25, AuditStatus.pending)).first);
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.open_in_browser,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              onTap: () async {
                Navigator.pushNamed(context, '/docs/revision', arguments: await apiServiceProvider.getDocumentByID(106));
                },
            ),
          ),
          Center(
            child: false ? FutureBuilder(
                future: apiServiceProvider.apiDocumentsTest(),
                builder: (BuildContext context, AsyncSnapshot<ImageProvider?> snapshot) {
                  return snapshot.hasData ? Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5),
                      color: Colors.red,
                    ),
                    child: snapshot.requireData != null ? Image(image: snapshot.requireData!) : const SizedBox(),
                  ) : const LoadingModal();
                }
            ) : const Text("disabled"),
          ),
        ],
      ),
    );
  }
}