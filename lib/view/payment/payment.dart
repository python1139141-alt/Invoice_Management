import 'package:flutter/material.dart';
import 'package:invoice_management/imports.dart';
import 'package:invoice_management/view/payment/add_payment_screen.dart';

import '../../controller/payment_controller.dart';
import '../../widgets/cards/payment_card_tile.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentCtrl = PaymentController();
    return Scaffold(
      body: ListView.builder(
        itemCount: paymentCtrl.paymentList.length,
        itemBuilder: (context, index) {
          return PaymentCardTile(data: paymentCtrl.paymentList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPaymentScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
