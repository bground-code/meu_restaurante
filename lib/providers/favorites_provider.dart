import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

  void addFavorite(Map<String, dynamic> item) {
    _favoriteItems.add(item);
    notifyListeners();
  }

  void removeFavorite(Map<String, dynamic> item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }
}
