enum Statistic {
  scanned_documents,
  audited_documents,
  signed_documents,
  archived_offers,
  archived_receipts,
  archived_internals;

  static Statistic fromString(String string) {
    switch (string) {
      case 'scanned_documents':
        return scanned_documents;
      case 'audited_documents':
        return audited_documents;
      case 'signed_documents':
        return signed_documents;
      case 'archived_offers':
        return archived_offers;
      case 'archived_receipts':
        return archived_receipts;
      case 'archived_internals':
        return archived_internals;
      default:
        return scanned_documents;
    }
  }

  String displayName() {
    switch (name) {
      case 'scanned_documents':
        return 'Skenirani dokumenti';
      case 'audited_documents':
        return 'Revidirani dokumenti';
      case 'signed_documents':
        return 'Potpisani dokumenti';
      case 'archived_offers':
        return 'Arhivirane ponude';
      case 'archived_receipts':
        return 'Arhivirani računi';
      case 'archived_internals':
        return 'Arhiviriani interni';
      default:
        return 'Skenirani dokumenti';
    }
  }
}