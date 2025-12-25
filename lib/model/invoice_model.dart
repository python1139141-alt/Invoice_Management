import './product_model.dart';

enum InvoiceStatus { paid, unpaid }

class LineItem {
  final ProductModel product;
  final int quantity;

  LineItem({required this.product, required this.quantity});

double get totalPrice => product.price * quantity;
}

class InvoiceModel {
  final String id;
  final String userName;
  final List<LineItem> items;
  final DateTime date;
  final InvoiceStatus status;
  final String? invoiceURL;

  InvoiceModel({
    required this.id,
    required this.userName,
    required this.items,
    required this.date,
    this.status = InvoiceStatus.unpaid,
    this.invoiceURL,
  });

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  InvoiceModel copyWith({
    String? id,
    String? userName,
    List<LineItem>? items,
    DateTime? date,
    InvoiceStatus? status,
    String? invoiceURL,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      items: items ?? this.items,
      date: date ?? this.date,
      status: status ?? this.status,
      invoiceURL: invoiceURL ?? this.invoiceURL,
    );
  }
}
