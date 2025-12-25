import 'package:invoice_management/imports.dart';
import '../model/tab_model.dart';

class TabControllers {
  final drawer = [
    TabModel('Home', Icons.home),
    TabModel('Invoice', Icons.receipt_long),
    TabModel('Payment', Icons.account_balance),
    TabModel('Settings', Icons.settings),
  ];
}
