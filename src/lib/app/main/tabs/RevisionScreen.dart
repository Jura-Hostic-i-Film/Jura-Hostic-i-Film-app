import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AddButton.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:jura_hostic_i_film_app/components/users/UserDisplayable.dart';
import 'package:provider/provider.dart';

import '../../../DTOs/AuditDTO.dart';
import '../../../backend_connection/ApiServiceProvider.dart';
import '../../../models/User.dart';
import '../../../models/audits/Audit.dart';
import '../../../models/audits/AuditStatus.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => RevisionScreenState();
}

class RevisionScreenState extends State<RevisionScreen> {
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
                        child: Text("Revidirani"),
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
                    future: apiServiceProvider.getUserAudits(AuditStatus.pending),
                    builder: (BuildContext context, AsyncSnapshot<List<Audit>> snapshot) {
                      return snapshot.hasData ? SingleChildScrollView(
                        child: Column(
                          children: snapshot.requireData
                              .asMap().map((i, audit) => MapEntry(
                            i,
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                    ),
                                  )
                              ),
                              child: Text(audit.document.id.toString()),
                            ),
                          )).values.toList(),
                        ),
                      ) : const LoadingModal();
                    }
                  ),
                  FutureBuilder(
                      future: apiServiceProvider.getUserAudits(AuditStatus.done),
                      builder: (BuildContext context, AsyncSnapshot<List<Audit>> snapshot) {
                        return snapshot.hasData ? SingleChildScrollView(
                          child: Column(
                            children: snapshot.requireData
                                .asMap().map((i, audit) => MapEntry(
                              i,
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                      ),
                                    )
                                ),
                                child: Text(audit.document.id.toString()),
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