import 'package:flutter/material.dart';

class SettingsModel {
  final String title;
  final IconData icon;
  final bool isLogout;
  final bool isTheme;

  SettingsModel({
    required this.title,
    required this.icon,
    this.isLogout = false,
    this.isTheme = false,
  });
}
