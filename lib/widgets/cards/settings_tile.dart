import 'package:flutter/material.dart';
import '../../model/settings_model.dart';
import '../text/text_builder.dart';

class SettingsTile extends StatelessWidget {
  final SettingsModel data;
  final Function()? onTap;
  final Widget? trailing;

  const SettingsTile({Key? key, required this.data, this.onTap, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = data.isLogout ? Colors.red : Theme.of(context).textTheme.bodyLarge?.color;
    return ListTile(
      onTap: onTap,
      leading: Icon(data.icon, color: color),
      title: TextBuilder(text: data.title, color: color),
      trailing: trailing,
    );
  }
}
