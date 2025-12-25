import 'package:uuid/uuid.dart';

class ProductModel {
  final String id;
  final String title;
  final String subTitle; // Represents quantity
  final double price;
  final String trailing; // Represents image url

  ProductModel({
    String? id,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.trailing,
  }) : id = id ?? const Uuid().v4();

  ProductModel copyWith({
    String? id,
    String? title,
    String? subTitle,
    double? price,
    String? trailing,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      price: price ?? this.price,
      trailing: trailing ?? this.trailing,
    );
  }
}
