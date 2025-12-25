import 'package:flutter/material.dart';
import '../../model/gst_model.dart';
import '../text/text_builder.dart';

class GstCardTile extends StatelessWidget {
  final GstModel data;
  const GstCardTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextBuilder(text: data.title),
      subtitle: TextBuilder(text: data.subTitle),
    );
  }
}
