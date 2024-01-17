import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:jura_hostic_i_film_app/components/signature/SignaturePendingDisplayable.dart';
import 'package:provider/provider.dart';

import '../../../backend_connection/ApiServiceProvider.dart';
import '../../../components/signature/SignatureDisplayable.dart';
import '../../../models/signatures/Signature.dart';
import '../../../models/signatures/SignatureStatus.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => SignatureScreenState();
}

class SignatureScreenState extends State<SignatureScreen> {
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
                      Icon(Icons.assignment_late_outlined),
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
                      Icon(Icons.assignment_turned_in),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text("Potpisani"),
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
                        future: apiServiceProvider.getUserSignatures(SignatureStatus.pending),
                        builder: (BuildContext context, AsyncSnapshot<List<Signature>> snapshot) {
                          return snapshot.hasData ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 60),
                              child: Column(
                                children: snapshot.requireData
                                    .asMap().map((i, signature) => MapEntry(
                                  i,
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                          ),
                                        )
                                    ),
                                    child: SignaturePendingDisplayable(signature: signature, callback: () => setState(() {})),
                                  ),
                                )).values.toList(),
                              ),
                            ),
                          ) : const LoadingModal();
                        }
                    ),
                    FutureBuilder(
                        future: apiServiceProvider.getUserSignatures(SignatureStatus.done),
                        builder: (BuildContext context, AsyncSnapshot<List<Signature>> snapshot) {
                          return snapshot.hasData ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 60),
                              child: Column(
                                children: snapshot.requireData
                                    .asMap().map((i, signature) => MapEntry(
                                  i,
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: i != snapshot.requireData.length - 1 ? Colors.black : Colors.transparent,
                                          ),
                                        )
                                    ),
                                    child: SignatureDisplayable(signature: signature),
                                  ),
                                )).values.toList(),
                              ),
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