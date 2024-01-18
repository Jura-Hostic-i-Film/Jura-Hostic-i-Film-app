import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/action_icons/ArchiveIcon.dart';
import 'package:jura_hostic_i_film_app/components/action_icons/SignatureIcon.dart';
import '../../models/signatures/Signature.dart';
import '../action_icons/DownloadOriginalIcon.dart';
import '../action_icons/OverviewIcon.dart';
import '../history/DocumentTypeDisplayable.dart';
import '../history/DocumentStatusDisplayable.dart';

class SignaturePendingDisplayable extends StatelessWidget {
  final Signature signature;
  final Function callback;
  const SignaturePendingDisplayable({required this.signature, required this.callback, super.key});

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
                              'Document ID: ${signature.document.id}',
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
                            'Stvoren: ${signature.document.scanTime.toString().split(".")[0]}\nSkenirao: ${signature.document.owner.username.toString()}\n',
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
                        SignatureIcon(signature: signature, callback: callback),
                        const SizedBox(width: 6),
                        OverviewIcon(document: signature.document),
                        const SizedBox(width: 6),
                        DownloadOriginalIcon(document: signature.document),
                      ],
                    ),
                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child:
                      DocumentStatusDisplayable(documentStatus: signature.document.documentStatus)
                  ),
                  const SizedBox(width:6),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child:
                      DocumentTypeDisplayable(documentType: signature.document.documentType)
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }}