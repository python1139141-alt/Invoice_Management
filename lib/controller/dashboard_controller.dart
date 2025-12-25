import 'package:flutter/material.dart';
import 'package:invoice_management/model/dashboard_model.dart';
import 'package:invoice_management/model/invoice_model.dart';
import 'invoice_controller.dart';

class DashboardController {
  final InvoiceController invoiceController;

  DashboardController(this.invoiceController);

  List<DashboardModel> get dashboardList {
    final invoices = invoiceController.invoices;
    final totalInvoices = invoices.length;
    final paidInvoices = invoices.where((inv) => inv.status == InvoiceStatus.paid).length;
    final unpaidInvoices = totalInvoices - paidInvoices;
    final totalRevenue = invoices.fold<double>(0, (sum, inv) => sum + inv.totalAmount);

    return [
      DashboardModel(
        title: 'Total Invoices',
        subTitle: totalInvoices.toString(),
        icon: Icons.receipt,
      ),
      DashboardModel(
        title: 'Paid Invoices',
        subTitle: paidInvoices.toString(),
        icon: Icons.check_circle,
      ),
      DashboardModel(
        title: 'Unpaid Invoices',
        subTitle: unpaidInvoices.toString(),
        icon: Icons.cancel,
      ),
      DashboardModel(
        title: 'Total Revenue',
        subTitle: '₹${totalRevenue.toStringAsFixed(2)}',
        icon: Icons.attach_money,
      ),
    ];
  }
}
