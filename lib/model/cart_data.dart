import 'package:flutter/foundation.dart';

import 'list_data.dart';

class CartModel extends ChangeNotifier {

  final List<ListData> _cartList = [];

  List<ListData> get items => _cartList;

  void add(ListData listData) {
    _cartList.add(listData);
    notifyListeners();
  }
}