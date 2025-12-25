import 'package:flutter/material.dart';
import '../model/payment_model.dart';

class PaymentController with ChangeNotifier {
  final List<PaymentModel> _paymentList = [];

  List<PaymentModel> get paymentList => _paymentList;

  void addPayment(PaymentModel payment) {
    _paymentList.add(payment);
    notifyListeners();
  }
}
