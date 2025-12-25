import 'package:flutter/material.dart';
import '../model/settings_model.dart';

class SettingsController {
  final list = [
    SettingsModel(title: 'Employee List', icon: Icons.people),
    SettingsModel(title: 'Product List', icon: Icons.list),
    SettingsModel(title: 'Add GST Number', icon: Icons.numbers),
    SettingsModel(title: 'Dark Mode', icon: Icons.dark_mode),
    SettingsModel(title: 'Reports', icon: Icons.bar_chart),
    SettingsModel(title: 'Log out', icon: Icons.logout, isLogout: true),
  ];
}
