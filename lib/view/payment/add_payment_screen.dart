import 'package:flutter/material.dart';
import 'package:invoice_management/imports.dart';
import 'package:invoice_management/model/payment_model.dart';
import 'package:provider/provider.dart';

import '../../controller/payment_controller.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({Key? key}) : super(key: key);

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: nameCtrl,
              label: 'User Name',
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: amountCtrl,
              label: 'Amount',
              prefixIcon: const Icon(Icons.money),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            Consumer<PaymentController>(
              builder: (context, paymentCtrl, child) {
                return ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.isNotEmpty && amountCtrl.text.isNotEmpty) {
                      paymentCtrl.addPayment(
                        PaymentModel(
                          userName: nameCtrl.text,
                          date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                          payment: '₹ ${amountCtrl.text}',
                          avatar: 'https://randomuser.me/api/portraits/men/${paymentCtrl.paymentList.length + 1}.jpg',
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Payment'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
