import 'package:flutter/material.dart';

enum DocumentType {
  receipt,
  offer,
  internal;

  static DocumentType fromJson(Map<String, dynamic> json) {
    switch (json['name'] as String) {
      case 'receipt':
        return receipt;
      case 'offer':
        return offer;
      case 'internal':
        return internal;
      default:
        return receipt;
    }
  }

  static DocumentType fromString(String string) {
    switch (string) {
      case 'receipt':
        return receipt;
      case 'offer':
        return offer;
      case 'internal':
        return internal;
      default:
        return receipt;
    }
  }

  String displayName() {
    switch (name) {
      case 'receipt':
        return 'Račun';
      case 'offer':
        return 'Ponuda';
      case 'internal':
        return 'Interni';
      default:
        return 'Račun';
    }
  }

  Color displayColor() {
    switch (name) {
      case 'receipt':
        return Colors.blueGrey;
      case 'offer':
        return Colors.blueAccent;
      case 'internal':
        return Colors.lightBlue;
      default:
        return Colors.blueGrey;
    }
  }
}