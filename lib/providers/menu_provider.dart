import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item_model.dart';

class MenuProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MenuItem> _menuItems = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'All';

  List<MenuItem> get menuItems => _menuItems;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  List<MenuItem> get filteredItems {
    if (_selectedCategory == 'All') {
      return _menuItems;
    }
    return _menuItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  Future<void> loadMenuItems() async {
    try {
      _isLoading = true;
      _errorMessage = null;

      final querySnapshot =
          await _firestore.collection('menu_items').get();

      _menuItems = querySnapshot.docs
          .map((doc) => MenuItem.fromJson(doc.data()))
          .toList();

      _loadCategories();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _loadCategories() {
    final categories = <String>{'All'};
    for (var item in _menuItems) {
      categories.add(item.category);
    }
    _categories = categories.toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  MenuItem? getItemById(String id) {
    try {
      return _menuItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  List<MenuItem> searchItems(String query) {
    if (query.isEmpty) return _menuItems;
    return _menuItems
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
