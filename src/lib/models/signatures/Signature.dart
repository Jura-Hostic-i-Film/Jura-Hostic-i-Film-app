import '../User.dart';
import '../documents/Document.dart';
import 'SignatureStatus.dart';

class Signature {
  int? signatureId;
  SignatureStatus status;
  DateTime? signedAt;
  User signed;
  Document document;


  Signature({
    required this.signatureId,
    required this.status,
    required this.signedAt,
    required this.signed,
    required this.document,
  });

  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(
      signatureId: json["signature_id"] as int,
      status: SignatureStatus.fromString(json["status"]),
      signedAt: json["signed_at"] != null ? DateTime.parse(json["signed_at"]) : null,
      signed: User.fromJson(json["signed"]),
      document: Document.fromJson(json["document"]),
    );
  }
}