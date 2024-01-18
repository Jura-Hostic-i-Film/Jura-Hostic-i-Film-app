import 'package:flutter/material.dart';

class SideTab {
  Widget screen;
  String name;
  String key;
  IconData? icon;
  bool enabled;

  SideTab({
    required this.screen,
    required this.name,
    required this.key,
    required this.icon,
    required this.enabled,
  });
}