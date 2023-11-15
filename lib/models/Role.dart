enum Role {
  admin,
  director,
  auditor,
  accountant,
  employee;

  static Role fromJson(Map<String, dynamic> json) {
    switch (json['name'] as String) {
      case 'admin':
        return Role.admin;
      case 'direktor':
        return Role.director;
      case 'auditor':
        return Role.auditor;
      case 'accountant':
        return Role.accountant;
      default:
        return Role.employee;
    }
  }
}