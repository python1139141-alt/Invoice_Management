import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice_management/imports.dart';
import '../../../../controller/gst_list_controller.dart';
import '../../../../model/gst_model.dart';
import '../../../../widgets/text/text_builder.dart';

class GSTHome extends StatelessWidget {
  const GSTHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(text: 'GST Number List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showGstFormSheet(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Consumer<GSTListController>(
          builder: (context, provider, child) {
            if (provider.gstList.isEmpty) {
              return const Center(
                child: TextBuilder(text: 'No GST numbers added yet.'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.gstList.length,
              itemBuilder: (BuildContext context, int i) {
                final gst = provider.gstList[i];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListTile(
                      title: TextBuilder(
                        text: gst.title,
                        fontSize: 18.0,
                      ),
                      subtitle: TextBuilder(
                        text: gst.subTitle,
                        fontSize: 12,
                      ),
                      onTap: () {
                        _showGstFormSheet(context, gst: gst);
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete ${gst.title}?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<GSTListController>(context, listen: false).removeGst(i);
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

void _showGstFormSheet(BuildContext context, {GstModel? gst}) {
  final bool isEditing = gst != null;
  final title = TextEditingController(text: isEditing ? gst!.title : '');
  final gstNumber = TextEditingController(text: isEditing ? gst.subTitle : '');

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
              TextBuilder(text: isEditing ? 'Edit GST' : 'Add GST', fontSize: 25.0, fontWeight: FontWeight.w700),
              const SizedBox(height: 20.0),
              CustomTextField(
                label: 'Title',
                controller: title,
                prefixIcon: const Icon(Icons.title),
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                label: 'GST Number',
                controller: gstNumber,
                prefixIcon: const Icon(Icons.numbers),
              ),
              const SizedBox(height: 30.0),
              MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color: Theme.of(ctx).colorScheme.primary,
                textColor: Theme.of(ctx).colorScheme.onPrimary,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: () {
                  final gstTitle = title.text;
                  final gstNum = gstNumber.text;

                  if (gstTitle.isNotEmpty && gstNum.isNotEmpty) {
                    final provider = Provider.of<GSTListController>(context, listen: false);
                    final newGst = GstModel(
                      title: gstTitle,
                      subTitle: gstNum,
                    );
                    if (isEditing) {
                      final index = provider.gstList.indexOf(gst);
                      provider.updateGst(index, newGst);
                    } else {
                      provider.addGst(newGst);
                    }
                    Navigator.pop(ctx);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Title and GST Number cannot be empty.')),
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
