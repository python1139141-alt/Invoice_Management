import 'package:flutter/material.dart';
import '../model/gst_model.dart';

class GSTListController with ChangeNotifier {
  final List<GstModel> _gstList = [];

  List<GstModel> get gstList => _gstList;

  void addGst(GstModel gst) {
    _gstList.add(gst);
    notifyListeners();
  }

  void removeGst(int index) {
    _gstList.removeAt(index);
    notifyListeners();
  }

  void updateGst(int index, GstModel gst) {
    _gstList[index] = gst;
    notifyListeners();
  }
}
