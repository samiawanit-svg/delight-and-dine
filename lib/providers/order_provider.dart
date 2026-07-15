import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';
import 'auth_provider.dart';

class OrderProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Order> _orders = [];
  Order? _currentOrder;
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get orders => _orders;
  Order? get currentOrder => _currentOrder;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadUserOrders(String userId) async {
    try {
      _isLoading = true;
      _errorMessage = null;

      final querySnapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('orderedAt', descending: true)
          .get();

      _orders = querySnapshot.docs
          .map((doc) => Order.fromJson(doc.data()))
          .toList();

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOrder({
    required String userId,
    required List<CartItem> items,
    required String deliveryAddress,
    required String paymentMethod,
    String specialInstructions = '',
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;

      final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
      final tax = subtotal * 0.05;
      const deliveryFee = 50.0;
      final total = subtotal + tax + deliveryFee;

      final order = Order(
        id: _firestore.collection('orders').doc().id,
        userId: userId,
        items: items,
        subtotal: subtotal,
        tax: tax,
        deliveryFee: deliveryFee,
        total: total,
        deliveryAddress: deliveryAddress,
        paymentMethod: paymentMethod,
        specialInstructions: specialInstructions,
        orderedAt: DateTime.now(),
      );

      await _firestore
          .collection('orders')
          .doc(order.id)
          .set(order.toJson());

      _currentOrder = order;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
        'orderUpdates': FieldValue.arrayUnion([
          '${DateTime.now().toString()}: Order status changed to $newStatus'
        ])
      });

      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index >= 0) {
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    try {
      await updateOrderStatus(orderId, 'cancelled');
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> getOrderDetails(String orderId) async {
    try {
      _isLoading = true;
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        _currentOrder = Order.fromJson(doc.data()!);
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
