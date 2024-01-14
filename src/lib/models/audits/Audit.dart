import '../User.dart';
import '../documents/Document.dart';
import 'AuditStatus.dart';

class Audit {
  int auditId;
  AuditStatus status;
  DateTime? auditedAt;
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
      status: AuditStatus.fromString(json["status"]),
      auditedAt: json["audited_at"] != null ? DateTime.parse(json["audited_at"]) : null,
      audited: User.fromJson(json["audited"]),
      document: Document.fromJson(json["document"]),
    );
  }
}