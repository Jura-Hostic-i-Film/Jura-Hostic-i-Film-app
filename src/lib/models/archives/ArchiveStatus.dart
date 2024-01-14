enum ArchiveStatus {
  pending,
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
      default:
        return pending;
    }
  }
}