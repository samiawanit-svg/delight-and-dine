import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/menu_item_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  double _taxPercentage = 0.05; // 5% tax
  double _deliveryFee = 50.0;

  List<CartItem> get items => _items;
  double get taxPercentage => _taxPercentage;
  double get deliveryFee => _deliveryFee;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get tax => subtotal * _taxPercentage;

  double get total => subtotal + tax + deliveryFee;

  void addItem(MenuItem item, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((e) => e.item.id == item.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(item: item, quantity: quantity));
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final index = _items.indexWhere((e) => e.item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void addSpecialRequest(String itemId, String request) {
    final index = _items.indexWhere((e) => e.item.id == itemId);
    if (index >= 0 && !_items[index].specialRequests.contains(request)) {
      _items[index].specialRequests.add(request);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool get isEmpty => _items.isEmpty;
}
