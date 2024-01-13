import 'package:jura_hostic_i_film_app/models/documents/DocumentType.dart';
import '../User.dart';
import '../documents/Document.dart';
import 'AuditStatus.dart';

class Audit {
  int auditId;
  AuditStatus status;
  DateTime auditedAt;
  User audited;
  Document document;


  Audit({
    required this.auditId,
    required this.status,
    required this.auditedAt,
    required this.audited,
    required this.document,
  });

  factory Audit.fromJson(Map<String, dynamic> json) {
    return Audit(
      auditId: json["audit_id"] as int,
      status: AuditStatus.fromString(json["document_status"]),
      auditedAt: DateTime.parse(json["scan_time"]),
      audited: User.fromJson(json["audited"]),
      document: Document.fromJson(json["document"]),
    );
  }
}