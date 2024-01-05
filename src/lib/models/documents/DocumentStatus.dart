import 'package:flutter/material.dart';

enum DocumentStatus {
  scanned,
  approved,
  refused,
  audited,
  archived,
  signed,
  signed_and_archived;

  static DocumentStatus fromJson(Map<String, dynamic> json) {
    switch (json['name'] as String) {
      case 'scanned':
        return scanned;
      case 'approved':
        return approved;
      case 'audited':
        return audited;
      case 'signed':
        return signed;
      case 'archived':
        return archived;
      case 'signed_and_archived':
        return signed_and_archived;
      default:
        return refused;
    }
  }

  String displayName() {
    switch (name) {
      case 'scanned':
        return 'Digitaliziran';
      case 'approved':
        return 'Odobren';
      case 'audited':
        return 'Revidiran';
      case 'signed':
        return 'Potpisan';
      case 'archived':
        return 'Arhiviran';
      case 'signed_and_archived':
        return 'Potpisan i Arhiviran';
      default:
        return 'Odbijen';
    }
  }

  Color displayColor() {
    switch (name) {
      case 'scanned':
        return Colors.redAccent;
      case 'approved':
        return Colors.orange;
      case 'audited':
        return Colors.yellow;
      case 'signed':
        return Colors.tealAccent;
      case 'archived':
        return Colors.green;
      case 'signed_and_archived':
        return Colors.teal;
      default:
        return Colors.red.shade800;
    }
  }
}