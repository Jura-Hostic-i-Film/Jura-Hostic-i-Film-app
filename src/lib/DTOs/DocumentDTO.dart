import 'package:image_picker/image_picker.dart';
import '../models/documents/Document.dart';

class DocumentDTO{
  Document? processedDocument;
  XFile imageFile;

  DocumentDTO(
      this.imageFile
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is DocumentDTO && other.imageFile == imageFile;
  }

  @override
  int get hashCode => imageFile.hashCode;

}