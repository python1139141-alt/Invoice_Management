import 'package:flutter/material.dart';
import 'package:invoice_management/controller/product_list_controller.dart';
import 'package:invoice_management/model/product_model.dart';
import 'package:invoice_management/widgets/text_field/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../controller/invoice_controller.dart';
import '../../../model/invoice_model.dart';
import '../../../widgets/text/text_builder.dart';

class CreateInvoiceTemplate extends StatefulWidget {
  const CreateInvoiceTemplate({Key? key}) : super(key: key);

  @override
  State<CreateInvoiceTemplate> createState() => _CreateInvoiceTemplateState();
}

class _CreateInvoiceTemplateState extends State<CreateInvoiceTemplate> {
  final nameCtrl = TextEditingController();
  final List<LineItem> _items = [];
  InvoiceStatus _selectedStatus = InvoiceStatus.unpaid;

  double get _totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void _addProduct() async {
    final productProvider = context.read<ProductListController>();
    final selectedProduct = await showDialog<ProductModel>(
      context: context,
      builder: (context) => _SelectProductDialog(products: productProvider.productList),
    );

    if (selectedProduct != null) {
      final quantity = await _showQuantityDialog();
      if (quantity != null && quantity > 0) {
        setState(() {
          _items.add(LineItem(product: selectedProduct, quantity: quantity));
        });
      }
    }
  }

  Future<int?> _showQuantityDialog() {
    final quantityCtrl = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Quantity'),
          content: CustomTextField(
            controller: quantityCtrl,
            label: 'Quantity',
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.inventory_2),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                final quantity = int.tryParse(quantityCtrl.text);
                Navigator.of(context).pop(quantity);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final invoiceCtrl = Provider.of<InvoiceController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(text: 'Create Invoice'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextBuilder(text: invoiceCtrl.nextInvoiceId(), fontSize: 15.0, color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 10),
            CustomTextField(controller: nameCtrl, label: 'Customer Name', prefixIcon: const Icon(Icons.person)),
            const SizedBox(height: 20),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextBuilder(text: 'Line Items', fontSize: 18.0),
                IconButton(icon: const Icon(Icons.add), onPressed: _addProduct),
              ],
            ),
            _items.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No products added')))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return ListTile(
                        title: Text(item.product.title),
                        subtitle: Text('Qty: ${item.quantity} @ ₹${item.product.price}'),
                        trailing: Text('₹${item.totalPrice.toStringAsFixed(2)}'),
                      );
                    },
                  ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [const Text('Total: ', style: TextStyle(fontSize: 18)), Text('₹${_totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<InvoiceStatus>(
              value: _selectedStatus,
              items: InvoiceStatus.values.map((s) => DropdownMenuItem(value: s, child: Text(s.toString().split('.').last))).toList(),
              onChanged: (value) => setState(() => _selectedStatus = value!),
              decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              textColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                if (nameCtrl.text.isEmpty || _items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Customer Name and at least one item are required")));
                  return;
                }
                invoiceCtrl.addInvoice(InvoiceModel(id: invoiceCtrl.nextInvoiceId(), userName: nameCtrl.text, items: _items, date: DateTime.now(), status: _selectedStatus));
                Navigator.pop(context);
              },
              child: const Text('CREATE INVOICE'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectProductDialog extends StatelessWidget {
  final List<ProductModel> products;
  const _SelectProductDialog({required this.products});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a Product'),
      content: SizedBox(
        width: double.maxFinite,
        child: products.isEmpty
            ? const Center(child: Text('No products available. Please add products in Settings.'))
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.title),
                    onTap: () => Navigator.of(context).pop(product),
                  );
                },
              ),
      ),
    );
  }
}
