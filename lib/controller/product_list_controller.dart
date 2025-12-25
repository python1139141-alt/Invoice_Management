import 'package:flutter/material.dart';
import '../model/product_model.dart';

class ProductListController with ChangeNotifier {
  final List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  void addProduct(ProductModel product) {
    _productList.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _productList.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void updateProduct(ProductModel product) {
    final index = _productList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _productList[index] = product;
      notifyListeners();
    }
  }
}
