import 'package:flutter/material.dart';
import '../../model/payment_model.dart';
import '../text/text_builder.dart';

class PaymentCardTile extends StatelessWidget {
  final PaymentModel? data;
  final Function()? onTap;

  const PaymentCardTile({Key? key, this.data, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: TextBuilder(
        text: data?.userName ?? '',
        fontSize: 18.0,
        color: Colors.black,
      ),
      subtitle: TextBuilder(
        text: data?.date ?? '',
        fontSize: 12,
      ),
      trailing: TextBuilder(text: '₹ ${data?.payment ?? ''}', fontSize: 15, color: Colors.black,),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(data?.avatar ?? ''),
      ),
    );
  }
}
