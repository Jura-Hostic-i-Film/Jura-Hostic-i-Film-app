import 'package:flutter/material.dart';

enum Role {
  admin,
  director,
  accountant_receipt,
  accountant_offer,
  accountant_internal,
  auditor,
  employee;

  static Role fromJson(Map<String, dynamic> json) {
    switch (json['name'] as String) {
      case 'admin':
        return Role.admin;
      case 'director':
        return Role.director;
      case 'accountant_receipt':
        return Role.accountant_receipt;
      case 'accountant_offer':
        return Role.accountant_offer;
      case 'accountant_internal':
        return Role.accountant_internal;
      case 'auditor':
        return Role.auditor;
      default:
        return Role.employee;
    }
  }

  String displayName() {
    switch (name) {
      case 'admin':
        return 'Administrator';
      case 'director':
        return 'Direktor';
      case 'accountant_receipt':
        return 'Računovođa (računi)';
      case 'accountant_offer':
        return 'Računovođa (ponude)';
      case 'accountant_internal':
        return 'Računovođa (interni)';
      case 'auditor':
        return 'Revizor';
      default:
        return 'Zaposlenik';
    }
  }

  Color displayColor() {
    switch (name) {
      case 'admin':
        return Colors.deepPurpleAccent;
      case 'director':
        return Colors.red.shade400;
      case 'accountant_receipt':
        return Colors.deepOrange.shade400;
      case 'accountant_offer':
        return Colors.deepOrange.shade400;
      case 'accountant_internal':
        return Colors.deepOrange.shade400;
      case 'auditor':
        return Colors.yellow.shade400;
      default:
        return Colors.green.shade400;
    }
  }

  static List<Role> getApplicable(List<Role> roles) {
    if (roles.contains(Role.employee)) return [];
    var returnValues = Role.values.toList();
    returnValues.remove(Role.admin);
    returnValues.removeWhere((role) => roles.contains(role));
    if (roles.isNotEmpty) returnValues.remove(Role.employee);
    return returnValues;
  }
}