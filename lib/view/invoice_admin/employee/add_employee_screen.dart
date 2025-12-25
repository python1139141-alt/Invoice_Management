import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/provider_controller.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final imageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: imageCtrl,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<ProviderController>(context, listen: false)
                    .addEmployee(
                  nameCtrl.text,
                  phoneCtrl.text,
                  imageCtrl.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
