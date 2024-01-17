import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/action_icons/ArchiveIcon.dart';
import '../../models/archives/Archive.dart';
import '../action_icons/DownloadOriginalIcon.dart';
import '../action_icons/OverviewIcon.dart';
import '../history/DocumentTypeDisplayable.dart';
import '../history/DocumentStatusDisplayable.dart';

class ArchivePendingDisplayable extends StatelessWidget {
  final Archive archive;
  final Function callback;

  const ArchivePendingDisplayable(
      {required this.archive, required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 10),
          padding: const EdgeInsetsDirectional.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Document ID: ${archive.document.id}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'Stvoren: ${archive.document.scanTime.toString().split(".")[0]}\nSkenirao: ${archive.document.owner.username.toString()}\n',
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ArchiveIcon(
                          key: const Key('archiveButtonKey'),
                          archive: archive,
                          callback: () => callback(),
                        ),
                        const SizedBox(width: 6),
                        OverviewIcon(document: archive.document),
                        const SizedBox(width: 6),
                        DownloadOriginalIcon(document: archive.document),
                      ],
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: DocumentStatusDisplayable(
                          documentStatus: archive.document.documentStatus)),
                  const SizedBox(width: 6),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: DocumentTypeDisplayable(
                          documentType: archive.document.documentType)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
