enum AuditStatus {
  pending,
  done;

  static AuditStatus fromJson(Map<String, dynamic> json) {
    return fromString(json['name'] as String);
  }

  static AuditStatus fromString(String string) {
    switch (string) {
      case 'pending':
        return pending;
      case 'done':
        return done;
      default:
        return pending;
    }
  }
}