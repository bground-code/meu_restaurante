import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  double get totalPrice =>
      _cartItems.fold(0, (total, item) => total + item['price']);

  void addItemToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItemFromCart(Map<String, dynamic> item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}
