import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../models/documents/Document.dart';

class LocalDocumentHandler {
  static Future<bool> saveLocally(BuildContext context, Document document) async {
    ApiServiceProvider apiServiceProvider =
    Provider.of<ApiServiceProvider>(context, listen: false);

    Uint8List? imageData = await apiServiceProvider.getImageDataByID(document.imageId);
    String? downloadFolderPath = await getDownloadPath();

    if (imageData == null || downloadFolderPath == null) {
      return false;
    }
    print(downloadFolderPath);

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
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      return null;
    }
    return directory?.path;
  }
}