enum ArchiveStatus {
  pending,
  signed_pending,
  awaiting_signature,
  done;

  static ArchiveStatus fromJson(Map<String, dynamic> json) {
    return fromString(json['name'] as String);
  }

  static ArchiveStatus fromString(String string) {
    switch (string) {
      case 'pending':
        return pending;
      case 'done':
        return done;
      case 'signed_pending':
        return signed_pending;
      case 'awaiting_signature':
        return awaiting_signature;
      default:
        return pending;
    }
  }
}
