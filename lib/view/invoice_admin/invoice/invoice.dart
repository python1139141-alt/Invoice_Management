import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/invoice_controller.dart';
import '../../../widgets/cards/invoice_card_tile.dart';

class Invoice extends StatelessWidget {
  const Invoice({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceCtrl = Provider.of<InvoiceController>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: invoiceCtrl.invoices.length,
          itemBuilder: (BuildContext context, int i) {
            return InvoiceCardTile(
              data: invoiceCtrl.invoices[i],
            );
          },
        ),
      ),
    );
  }
}
