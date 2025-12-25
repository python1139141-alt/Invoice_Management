import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import '../text/text_builder.dart';

class ProductCardTile extends StatelessWidget {
  final ProductModel data;
  const ProductCardTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data.trailing),
      ),
      title: TextBuilder(text: data.title),
      subtitle: TextBuilder(text: "Qty: ${data.subTitle}"),
    );
  }
}
