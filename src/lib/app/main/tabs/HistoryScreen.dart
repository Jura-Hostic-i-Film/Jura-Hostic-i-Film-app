import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AddButton.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentDisplayable.dart';
import 'package:provider/provider.dart';
import 'package:jura_hostic_i_film_app/models/documents/Document.dart';
import '../../../backend_connection/ApiServiceProvider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: FutureBuilder(
                future: apiServiceProvider.getUserDocuments(),
                builder: (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
                  return snapshot.hasData ? Container(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                children: snapshot.requireData
                                    .toList()
                                    .asMap().map((i, document) => MapEntry(
                                  i,
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: i != snapshot.requireData.length - 2 ? Colors.black : Colors.transparent,
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
                  ) : const LoadingModal();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}