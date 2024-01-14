enum SignatureStatus {
  pending,
  done;

  static SignatureStatus fromJson(Map<String, dynamic> json) {
    return fromString(json['name'] as String);
  }

  static SignatureStatus fromString(String string) {
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