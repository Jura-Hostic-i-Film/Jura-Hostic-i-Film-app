import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:jura_hostic_i_film_app/components/history/DocumentDisplayable.dart';
import 'package:provider/provider.dart';
import 'package:jura_hostic_i_film_app/models/documents/Document.dart';
import '../../../backend_connection/ApiServiceProvider.dart';
import '../../../components/buttons/StatusButton.dart';
import '../../../components/buttons/TypeButton.dart';
import '../../../models/documents/DocumentStatus.dart';
import '../../../models/documents/DocumentType.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final GlobalKey statusDropdownKey = GlobalKey();
  final GlobalKey typeDropdownKey = GlobalKey();

  DocumentStatus? statusQuery;
  DocumentType? typeQuery;

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider =
    Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: FutureBuilder(
                future: apiServiceProvider.getUserDocuments(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Document>> snapshot) {
                  if (snapshot.hasData) {
                    List<Document> children = snapshot.requireData
                        .where((document) {
                      if (statusQuery != null &&
                          document.documentStatus !=
                              statusQuery) {
                        return false;
                      }
                      if (typeQuery != null &&
                          document.documentType !=
                              typeQuery) {
                        return false;
                      }
                      return true;
                    }).toList();

                    return Container(
                      padding: const EdgeInsets.only(top: 86),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 60),
                                child: Column(
                                    children: children
                                        .asMap()
                                        .map((i, document) => MapEntry(
                                      i,
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: i !=
                                                    children.length - 1
                                                    ? Colors.black
                                                    : Colors.transparent,
                                              ),
                                            )),
                                        child: DocumentDisplayable(
                                            document: document),
                                      ),
                                    ))
                                        .values
                                        .toList()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const LoadingModal();
                  }
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 86,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 8,
                            children: [
                              Stack(
                                children: [
                                  StatusButton(
                                    status: statusQuery,
                                    onTap: () {},
                                    fontSize: 12,
                                  ),
                                  Positioned.fill(
                                    child: Theme(
                                      data: ThemeData(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                      ),
                                      child: DropdownButton<DocumentStatus>(
                                          isExpanded: true,
                                          iconSize: 0,
                                          underline: const SizedBox(),
                                          key: statusDropdownKey,
                                          items: DocumentStatus.values
                                              .map(
                                                (status) => DropdownMenuItem(
                                              value: status,
                                              child: Text(
                                                status.displayName(),
                                              ),
                                            ),
                                          ).toList(),
                                          onChanged: (DocumentStatus? status) {
                                            setState(() {
                                              statusQuery = status;
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  TypeButton(
                                    type: typeQuery,
                                    onTap: () {},
                                    fontSize: 12,
                                  ),
                                  Positioned.fill(
                                    child: Theme(
                                      data: ThemeData(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                      ),
                                      child: DropdownButton<DocumentType>(
                                          isExpanded: true,
                                          iconSize: 0,
                                          underline: const SizedBox(),
                                          key: typeDropdownKey,
                                          items: DocumentType.values
                                              .map(
                                                (type) => DropdownMenuItem(
                                              value: type,
                                              child: Text(
                                                type.displayName(),
                                              ),
                                            ),
                                          ).toList(),
                                          onChanged: (DocumentType? type) {
                                            setState(() {
                                              typeQuery = type;
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.filter_alt_off,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ),
                                onTap: () => setState(
                                        () {
                                      statusQuery = null;
                                      typeQuery = null;
                                    }
                                ),
                              ),
                              GestureDetector(
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
                            ],
                          ),
                        ],
                      ),
                      //margin: const EdgeInsets.only(bottom: 10),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
