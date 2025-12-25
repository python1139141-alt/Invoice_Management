import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../model/employerr_model.dart';

class ProviderController extends ChangeNotifier {
  final List<EmployeeModel> _employees = [];

  List<EmployeeModel> get employees => _employees;

  // Add Employee
  void addEmployee(String name, String phone, String image) {
    final id = const Uuid().v4();

    _employees.add(
      EmployeeModel(
        id: id,
        name: name,
        phone: phone,
        image: image,
      ),
    );

    notifyListeners();
  }

  // Delete Employee
  void deleteEmployee(String id) {
    _employees.removeWhere((emp) => emp.id == id);
    notifyListeners();
  }

  // Update
  void updateEmployee(String id, String name, String phone, String image) {
    final index = _employees.indexWhere((emp) => emp.id == id);
    if (index != -1) {
      _employees[index] = EmployeeModel(
        id: id,
        name: name,
        phone: phone,
        image: image,
      );
      notifyListeners();
    }
  }

  // Search
  List<EmployeeModel> searchEmployee(String query) {
    return _employees
        .where((emp) =>
    emp.name.toLowerCase().contains(query.toLowerCase()) ||
        emp.phone.contains(query))
        .toList();
  }

  int get totalEmployees => _employees.length;

  void clearAll() {
    _employees.clear();
    notifyListeners();
  }
}
