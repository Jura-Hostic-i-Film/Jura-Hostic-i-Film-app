import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:jura_hostic_i_film_app/models/archives/ArchiveStatus.dart';
import 'package:jura_hostic_i_film_app/components/archive/ArchivedDisplayable.dart';
import 'package:jura_hostic_i_film_app/components/archive/ArchivePendingDisplayable.dart';
import 'package:provider/provider.dart';

import '../../../backend_connection/ApiServiceProvider.dart';
import '../../../models/archives/Archive.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => ArchiveScreenState();
}

class ArchiveScreenState extends State<ArchiveScreen> {

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: AppBar(
            surfaceTintColor: Colors.black,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.rate_review_outlined),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text("Predstojeći"),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text("Arhivirani"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: TabBarView(
                  children: [
                    FutureBuilder(
                        future: apiServiceProvider.getUserArchives(ArchiveStatus.pending),
                        builder: (BuildContext context, AsyncSnapshot<List<Archive>> snapshot) {
                          return snapshot.hasData ? SingleChildScrollView(
                            child: Column(
                              children: snapshot.requireData
                                  .asMap().map((i, archive) => MapEntry(
                                i,
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                        ),
                                      )
                                  ),
                                  child: ArchivePendingDisplayable(archive: archive),
                                ),
                              )).values.toList(),
                            ),
                          ) : const LoadingModal();
                        }
                    ),
                    FutureBuilder(
                        future: apiServiceProvider.getUserArchives(ArchiveStatus.done),
                        builder: (BuildContext context, AsyncSnapshot<List<Archive>> snapshot) {
                          return snapshot.hasData ? SingleChildScrollView(
                            child: Column(
                              children: snapshot.requireData
                                  .asMap().map((i, archive) => MapEntry(
                                i,
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                        ),
                                      )
                                  ),
                                  child: ArchivedDisplayable(archive: archive),
                                ),
                              )).values.toList(),
                            ),
                          ) : const LoadingModal();
                        }
                    ),
                  ],
                )
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