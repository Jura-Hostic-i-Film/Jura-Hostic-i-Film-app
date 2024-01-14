import '../User.dart';
import '../documents/Document.dart';
import 'ArchiveStatus.dart';

class Archive {
  int? archiveNumber;
  ArchiveStatus status;
  DateTime? archiveAt;
  User archived;
  Document document;


  Archive({
    required this.archiveNumber,
    required this.status,
    required this.archiveAt,
    required this.archived,
    required this.document,
  });

  factory Archive.fromJson(Map<String, dynamic> json) {
    return Archive(
      archiveNumber: json["archive_number"] != null ? json["archive_number"] as int : null,
      status: ArchiveStatus.fromString(json["status"]),
      archiveAt: json["archive_at"] != null ? DateTime.parse(json["archive_at"]) : null,
      archived: User.fromJson(json["archived"]),
      document: Document.fromJson(json["document"]),
    );
  }
}