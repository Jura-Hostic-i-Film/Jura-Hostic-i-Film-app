enum Role {
  admin,
  director,
  auditorReceipt,
  auditorOffer,
  auditorInternal,
  accountant,
  employee;

  static Role fromJson(Map<String, dynamic> json) {
    switch (json['name'] as String) {
      case 'admin':
        return Role.admin;
      case 'director':
        return Role.director;
      case 'auditor_receipt':
        return Role.auditorReceipt;
      case 'auditor_offer':
        return Role.auditorOffer;
      case 'auditor_internal':
        return Role.auditorInternal;
      case 'accountant':
        return Role.accountant;
      default:
        return Role.employee;
    }
  }
}