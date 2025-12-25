import 'package:flutter/material.dart';
import 'package:invoice_management/utils/app_theme.dart';
import 'package:invoice_management/view/invoice_admin/settings/GST/gst_home.dart';
import 'package:invoice_management/view/invoice_admin/settings/employee/employee.dart';
import 'package:invoice_management/view/invoice_admin/settings/product/product_home.dart';
import 'package:provider/provider.dart';

import '../../../controller/settings_controller.dart';
import '../../../widgets/cards/settings_tile.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsCtrl = SettingsController();

    return Scaffold(
      body: ListView.builder(
        itemCount: settingsCtrl.list.length,
        itemBuilder: (context, index) {
          final setting = settingsCtrl.list[index];
          if (setting.isTheme) {
            return Consumer<ThemeController>(
              builder: (context, themeCtrl, child) {
                return SettingsTile(
                  data: setting,
                  trailing: Switch(
                    value: themeCtrl.isDarkMode,
                    onChanged: (value) => themeCtrl.toggleTheme(),
                  ),
                );
              },
            );
          } else {
            return SettingsTile(
              data: setting,
              onTap: () {
                switch (setting.title) {
                  case 'Employee List':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Employee()));
                    break;
                  case 'Product List':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductHome()));
                    break;
                  case 'Add GST Number':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GSTHome()));
                    break;
                  case 'Log out':
                  // Handle Logout
                    break;
                }
              },
            );
          }
        },
      ),
    );
  }
}
