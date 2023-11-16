import 'package:flutter/material.dart';

enum Role {
  admin,
  director,
  accountantReceipt,
  accountantOffer,
  accountantInternal,
  auditor,
  employee;

  static Role fromJson(Map<String, dynamic> json) {
    switch (json['name'] as String) {
      case 'admin':
        return Role.admin;
      case 'director':
        return Role.director;
      case 'accountant_receipt':
        return Role.accountantReceipt;
      case 'accountant_offer':
        return Role.accountantOffer;
      case 'accountant_internal':
        return Role.accountantInternal;
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
      case 'accountantReceipt':
        return 'Računovođa (računi)';
      case 'accountantOffer':
        return 'Računovođa (ponude)';
      case 'accountantInternal':
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
      case 'accountantReceipt':
        return Colors.deepOrange.shade400;
      case 'accountantOffer':
        return Colors.deepOrange.shade400;
      case 'accountantInternal':
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