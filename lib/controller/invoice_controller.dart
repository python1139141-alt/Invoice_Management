import 'package:flutter/material.dart';
import '../model/invoice_model.dart';

class InvoiceController with ChangeNotifier {
  final List<InvoiceModel> _invoices = [];

  List<InvoiceModel> get invoices => _invoices;

  void addInvoice(InvoiceModel invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }

  String nextInvoiceId() {
    return "INV-${_invoices.length + 1}";
  }

  void updateInvoiceStatus(String id, InvoiceStatus newStatus) {
    try {
      final index = _invoices.indexWhere((inv) => inv.id == id);
      if (index != -1) {
        _invoices[index] = _invoices[index].copyWith(status: newStatus);
        notifyListeners();
      }
    } catch (e) {
      // handle error, e.g. invoice not found
    }
  }
}
