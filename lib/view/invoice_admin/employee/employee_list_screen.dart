import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/provider_controller.dart';
import 'add_employee_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEmployeeScreen()),
          );
        },
      ),
      body: ListView.builder(
        itemCount: provider.employees.length,
        itemBuilder: (context, index) {
          final emp = provider.employees[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: emp.image.isNotEmpty
                  ? NetworkImage(emp.image)
                  : null,
            ),
            title: Text(emp.name),
            subtitle: Text(emp.phone),
          );
        },
      ),
    );
  }
}
