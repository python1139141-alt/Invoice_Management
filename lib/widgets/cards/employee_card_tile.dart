import 'package:flutter/material.dart';
import '../../model/employerr_model.dart';
import '../text/text_builder.dart';

class EmployeeCardTile extends StatelessWidget {
  final EmployeeModel data;
  const EmployeeCardTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data.image),
      ),
      title: TextBuilder(text: data.name),
      subtitle: TextBuilder(text: data.phone),
    );
  }
}
