import 'package:jura_hostic_i_film_app/models/documents/DocumentType.dart';
import '../User.dart';
import 'DocumentStatus.dart';

class Document {
  int id;
  int imageId;
  User owner;
  DocumentType documentType;
  String summary;
  DocumentStatus documentStatus;
  DateTime scanTime;

  Document({
    required this.id,
    required this.imageId,
    required this.owner,
    required this.documentType,
    required this.summary,
    required this.documentStatus,
    required this.scanTime,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json["id"] as int,
      imageId: json["image_id"] as int,
      owner: User.fromJson(json["owner"]),
      documentType: DocumentType.fromJson(json["document_type"]),
      summary: json["summary"],
      documentStatus: DocumentStatus.fromJson(json["document_status"]),
      scanTime: DateTime.parse(json["scan_time"]),
    );
  }
}