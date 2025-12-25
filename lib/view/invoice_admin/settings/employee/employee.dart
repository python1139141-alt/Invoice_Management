import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice_management/controller/provider/provider_controller.dart';
import 'package:invoice_management/model/employerr_model.dart';
import 'package:invoice_management/imports.dart';

import '../../../../widgets/text/text_builder.dart';

class Employee extends StatelessWidget {
  const Employee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(text: 'Employee List'),
      ),
      body: SafeArea(
        child: Consumer<ProviderController>(
          builder: (context, provider, child) {
            if (provider.employees.isEmpty) {
              return const Center(
                child: TextBuilder(text: 'No employees added yet.'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.employees.length,
              itemBuilder: (BuildContext context, int i) {
                final employee = provider.employees[i];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        maxRadius: 30.0,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                        backgroundImage: NetworkImage(employee.image),
                      ),
                      title: TextBuilder(
                        text: employee.name,
                        fontSize: 18.0,
                      ),
                      subtitle: TextBuilder(
                        text: 'Phone: ${employee.phone}',
                        fontSize: 12,
                      ),
                      onTap: () {
                        _showEmployeeFormSheet(context, employee: employee);
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete ${employee.name}?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<ProviderController>(context, listen: false).deleteEmployee(employee.id);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEmployeeFormSheet(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

void _showEmployeeFormSheet(BuildContext context, {EmployeeModel? employee}) {
  final bool isEditing = employee != null;
  final fullName = TextEditingController(text: isEditing ? employee!.name : '');
  final phoneNumber = TextEditingController(text: isEditing ? employee.phone : '');
  final imageUrl = TextEditingController(text: isEditing ? employee.image : '');

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
              TextBuilder(text: isEditing ? 'Edit Employee' : 'Add Employee', fontSize: 25.0, fontWeight: FontWeight.w700),
              const SizedBox(height: 20.0),
              CustomTextField(
                label: 'Full Name',
                controller: fullName,
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                label: 'Phone Number',
                controller: phoneNumber,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
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
                  final name = fullName.text;
                  final phone = phoneNumber.text;
                  final image = imageUrl.text;

                  if (name.isNotEmpty && phone.isNotEmpty) {
                    final provider = Provider.of<ProviderController>(context, listen: false);
                    if (isEditing) {
                      provider.updateEmployee(
                        employee.id,
                        name,
                        phone,
                        image.isNotEmpty ? image : 'https://www.gravatar.com/avatar/${name.hashCode}?d=identicon',
                      );
                    } else {
                      provider.addEmployee(
                        name,
                        phone,
                        image.isNotEmpty ? image : 'https://www.gravatar.com/avatar/${name.hashCode}?d=identicon',
                      );
                    }
                    Navigator.pop(ctx);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Name and Phone cannot be empty.')),
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
