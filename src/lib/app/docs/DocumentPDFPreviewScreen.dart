import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/util/LocalDocumentHandler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../models/Role.dart';
import '../../models/documents/Document.dart';

class DocumentPDFPreviewScreen extends StatelessWidget {
  const DocumentPDFPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    final Document document =
    ModalRoute.of(context)!.settings.arguments as Document;

    return Scaffold(
        body: Theme(
          data: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.black,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: PdfPreview(
            allowSharing: apiServiceProvider.currentUser!.roles.contains(Role.director),
            canChangePageFormat: true,
            canChangeOrientation: false,
            canDebug: false,
            pdfFileName: 'dokument_${document.id}.pdf',
            build: (context) => LocalDocumentHandler.createPDF(document),
          ),
        )
    );
  }
}