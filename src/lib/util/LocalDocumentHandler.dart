import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart' as mat;
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../models/documents/Document.dart' as dox;
import 'package:pdf/widgets.dart';

import '../models/documents/DocumentType.dart';

class LocalDocumentHandler {
  static Future<bool> saveLocally(
      mat.BuildContext context, dox.Document document) async {
    ApiServiceProvider apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: false);

    Uint8List? imageData =
        await apiServiceProvider.getImageDataByID(document.imageId);
    String? downloadFolderPath = await getDownloadPath();

    if (imageData == null || downloadFolderPath == null) {
      return false;
    }

    final file = File('$downloadFolderPath/${document.id}.jpeg');
    await file.create(recursive: false);
    await file.writeAsBytes(imageData.buffer.asInt8List());

    return true;
  }

  static Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      return null;
    }
    return directory?.path;
  }

  static Future<Uint8List> createPDF(dox.Document document) async {
    Document pdf = Document(
      theme: ThemeData.withFont(
        base: await PdfGoogleFonts.robotoRegular(),
        bold: await PdfGoogleFonts.robotoBold(),
        italic: await PdfGoogleFonts.robotoItalic(),
        boldItalic: await PdfGoogleFonts.robotoBoldItalic(),
      )
    );

    List<String> lines = document.summary
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .toList();

    if ((document.documentType == DocumentType.internal && lines.length < 2)
        || (document.documentType == DocumentType.receipt && lines.length < 4)
        || (document.documentType == DocumentType.offer && lines.length < 3)) {
      pdf.addPage(Page(build: (context) {
        return Text(document.summary);
      }));

      return pdf.save();
    }

    pdf.addPage(Page(build: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              lines[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          document.documentType == DocumentType.receipt ? Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              lines[1],
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ) : SizedBox(),
        ] + (document.documentType == DocumentType.internal ? lines.sublist(1).map((line) => Text(
          line,
          style: const TextStyle(
            fontSize: 12,
          ),
        )).toList() : <Widget>[Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            lines[document.documentType == DocumentType.receipt ? 2 : 1],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        )] + lines.sublist(document.documentType == DocumentType.receipt ? 3 : 2, lines.length - 1).map((line) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            line,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        )).toList() + [Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            lines.last,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        )]),
      );
    }));

    return pdf.save();
  }
}
