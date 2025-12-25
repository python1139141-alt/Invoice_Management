import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controller/invoice_controller.dart';
import '../../model/invoice_model.dart';
import '../text/text_builder.dart';

class InvoiceCardTile extends StatelessWidget {
  final InvoiceModel data;
  const InvoiceCardTile({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextBuilder(text: data.userName, fontSize: 18.0, color: Colors.black),
      subtitle: TextBuilder(text: DateFormat('dd MMM yyyy').format(data.date), fontSize: 12),
      leading: CircleAvatar(
        radius: 5,
        backgroundColor: data.status == InvoiceStatus.paid ? Colors.green : Colors.red,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBuilder(
            text: '₹ ${data.totalAmount.toStringAsFixed(2)}',
            fontSize: 15,
            color: Colors.black,
          ),
          if (data.status == InvoiceStatus.unpaid)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'paid') {
                  Provider.of<InvoiceController>(context, listen: false).updateInvoiceStatus(data.id, InvoiceStatus.paid);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'paid',
                  child: Text('Mark as Paid'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
