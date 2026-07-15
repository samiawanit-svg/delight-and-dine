import 'menu_item_model.dart';

class CartItem {
  final MenuItem item;
  int quantity;
  final List<String> specialRequests;

  CartItem({
    required this.item,
    this.quantity = 1,
    this.specialRequests = const [],
  });

  double get totalPrice => item.price * quantity;

  Map<String, dynamic> toJson() => {
        'item': item.toJson(),
        'quantity': quantity,
        'specialRequests': specialRequests,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        item: MenuItem.fromJson(json['item']),
        quantity: json['quantity'] ?? 1,
        specialRequests: List<String>.from(json['specialRequests'] ?? []),
      );
}
