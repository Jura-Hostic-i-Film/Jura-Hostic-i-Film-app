import 'package:flutter/material.dart';

import '../components/loading/LoadingModal.dart';

class LoadingDialog {
  static void useLoadingDialog<G, V>(
    BuildContext context,
    Future<(G, V)> future,
    String successMessage,
    String failMessage,
    Function successCallback,
    Function failCallback,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<(G, V)> snapshot) {
              return SimpleDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
                titlePadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.all(12),
                children: [
                  SizedBox(
                    width: 120,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: snapshot.hasData
                          ? [
                              Text(
                                key: Key(snapshot.requireData.$1 != null
                                    ? 'successMessageKey'
                                    : 'failMessageKey'),
                                snapshot.requireData.$1 != null
                                    ? successMessage
                                    : failMessage,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    key: const Key('closeDialogButtonKey'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (snapshot.requireData.$1 != null) {
                                        successCallback();
                                      } else {
                                        failCallback();
                                      }
                                    },
                                    child: const Text(
                                      "U redu",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          : [
                              const SizedBox(
                                width: 60,
                                height: 60,
                                child: LoadingModal(),
                              ),
                            ],
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
