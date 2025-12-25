import 'package:flutter/material.dart';
import 'package:invoice_management/widgets/text/text_builder.dart';

class FabCTA extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const FabCTA({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextBuilder(
          text: title,
          fontSize: 12,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
