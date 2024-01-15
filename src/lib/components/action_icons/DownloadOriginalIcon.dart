import 'package:flutter/material.dart';
import '../../models/documents/Document.dart';
import '../../util/LocalDocumentHandler.dart';
import '../loading/LoadingModal.dart';

class DownloadOriginalIcon extends StatelessWidget {
  final Document document;
  const DownloadOriginalIcon({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FutureBuilder(
                future: LocalDocumentHandler.saveLocally(
                    context, document),
                builder: (BuildContext context,
                    AsyncSnapshot<bool> snapshot) {
                  return SimpleDialog(
                    titlePadding: EdgeInsets.zero,
                    contentPadding: const EdgeInsets.all(12),
                    children: [
                      SizedBox(
                        width: 120,
                        height: 80,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: snapshot.hasData
                              ? [
                            Text(
                              snapshot.requireData
                                  ? "Dokument je uspješno preuzet, provjerite mapu za preuzimanja."
                                  : "Nije bilo moguće preuzeti dokument.",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .end,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pop(
                                          context),
                                  child: const Text(
                                    "U redu",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight
                                          .bold,
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
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.download,
          size: 28,
        ),
      ),
    );
  }

}