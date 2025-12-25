import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice_management/imports.dart';
import '../../../../controller/product_list_controller.dart';
import '../../../../model/product_model.dart';

class ProductHome extends StatelessWidget {
  const ProductHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(text: 'Product List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProductFormSheet(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Consumer<ProductListController>(
          builder: (context, provider, child) {
            if (provider.productList.isEmpty) {
              return const Center(
                child: TextBuilder(text: 'No products added yet.'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.productList.length,
              itemBuilder: (BuildContext context, int i) {
                final product = provider.productList[i];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        maxRadius: 30.0,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                        backgroundImage: NetworkImage(product.trailing),
                      ),
                      title: TextBuilder(
                        text: product.title,
                        fontSize: 18.0,
                      ),
                      subtitle: TextBuilder(
                        text: 'Qty: ${product.subTitle} | Price: ₹${product.price}',
                        fontSize: 12,
                      ),
                      onTap: () {
                        _showProductFormSheet(context, product: product);
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete ${product.title}?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<ProductListController>(context, listen: false).removeProduct(product.id);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('Delete', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void _showProductFormSheet(BuildContext context, {ProductModel? product}) {
  final bool isEditing = product != null;
  final title = TextEditingController(text: isEditing ? product!.title : '');
  final quantity = TextEditingController(text: isEditing ? product.subTitle : '');
  final price = TextEditingController(text: isEditing ? product.price.toString() : '');
  final imageUrl = TextEditingController(text: isEditing ? product.trailing : '');

  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    builder: (ctx) {
      return Container(
        padding: MediaQuery.of(ctx).viewInsets,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBuilder(text: isEditing ? 'Edit Product' : 'Add Product', fontSize: 25.0, fontWeight: FontWeight.w700),
              const SizedBox(height: 20.0),
              CustomTextField(
                label: 'Product Name',
                controller: title,
                prefixIcon: const Icon(Icons.shopping_bag),
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                label: 'Quantity',
                controller: quantity,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.inventory_2),
              ),
               const SizedBox(height: 15.0),
              CustomTextField(
                label: 'Price',
                controller: price,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(Icons.attach_money),
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                label: 'Image URL',
                controller: imageUrl,
                prefixIcon: const Icon(Icons.image),
              ),
              const SizedBox(height: 30.0),
              MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color: Theme.of(ctx).colorScheme.primary,
                textColor: Theme.of(ctx).colorScheme.onPrimary,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: () {
                  final name = title.text;
                  final qty = quantity.text;
                  final priceValue = double.tryParse(price.text) ?? 0.0;
                  final image = imageUrl.text;

                  if (name.isNotEmpty && qty.isNotEmpty) {
                    final provider = Provider.of<ProductListController>(context, listen: false);
                    final newProduct = ProductModel(
                      id: isEditing ? product.id : null,
                      title: name,
                      subTitle: qty,
                      price: priceValue,
                      trailing: image.isNotEmpty ? image : 'https://www.gravatar.com/avatar/${name.hashCode}?d=identicon',
                    );
                    if (isEditing) {
                      provider.updateProduct(newProduct);
                    } else {
                      provider.addProduct(newProduct);
                    }
                    Navigator.pop(ctx);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Name, Quantity and Price cannot be empty.')),
                    );
                  }
                },
                child: TextBuilder(
                  text: (isEditing ? 'Update' : 'Add').toUpperCase(),
                  color: Theme.of(ctx).colorScheme.onPrimary,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
