import 'package:flutter/material.dart';
import 'package:invoice_management/controller/dashboard_controller.dart';
import 'package:invoice_management/controller/invoice_controller.dart';
import 'package:invoice_management/imports.dart';
import 'package:invoice_management/view/invoice_admin/create_invoice/create_invoice.dart';
import 'package:invoice_management/widgets/cards/stats_card_tile.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<InvoiceController>(
          builder: (context, invoiceCtrl, child) {
            final dash = DashboardController(invoiceCtrl);
            return GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1.6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: dash.dashboardList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return StatsCardTile(data: dash, index: index);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateInvoiceTemplate()),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
