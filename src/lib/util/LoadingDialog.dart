import 'package:flutter/material.dart';

import '../components/loading/LoadingModal.dart';

class LoadingDialog {
  static void useLoadingDialog<G>(
    BuildContext context,
    Future<G> future,
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
            builder: (BuildContext context, AsyncSnapshot<G> snapshot) {
              return SimpleDialog(
                titlePadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.all(12),
                children: [
                  SizedBox(
                    width: 120,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: snapshot.hasData
                          ? [
                              Text(
                                snapshot.requireData != null
                                    ? successMessage
                                    : failMessage,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (snapshot.requireData != null) {
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
