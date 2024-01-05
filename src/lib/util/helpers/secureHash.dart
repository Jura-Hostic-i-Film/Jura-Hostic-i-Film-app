import 'dart:convert';
import 'package:crypto/crypto.dart';

String secureHash(String value) {
  return sha1.convert(
    utf8.encode(
      value
    )
  ).toString();
}