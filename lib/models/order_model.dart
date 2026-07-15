import 'cart_item_model.dart';

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final String deliveryAddress;
  final String status; // pending, confirmed, preparing, ready, out_for_delivery, delivered, cancelled
  final String paymentMethod; // card, upi, cash
  final bool isPaymentDone;
  final String specialInstructions;
  final DateTime orderedAt;
  final DateTime? estimatedDeliveryTime;
  final String? driverName;
  final String? driverPhone;
  final double? driverLat;
  final double? driverLng;
  final List<String> orderUpdates;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.deliveryAddress,
    this.status = 'pending',
    this.paymentMethod = 'card',
    this.isPaymentDone = false,
    this.specialInstructions = '',
    required this.orderedAt,
    this.estimatedDeliveryTime,
    this.driverName,
    this.driverPhone,
    this.driverLat,
    this.driverLng,
    this.orderUpdates = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'items': items.map((e) => e.toJson()).toList(),
        'subtotal': subtotal,
        'tax': tax,
        'deliveryFee': deliveryFee,
        'total': total,
        'deliveryAddress': deliveryAddress,
        'status': status,
        'paymentMethod': paymentMethod,
        'isPaymentDone': isPaymentDone,
        'specialInstructions': specialInstructions,
        'orderedAt': orderedAt.toIso8601String(),
        'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
        'driverName': driverName,
        'driverPhone': driverPhone,
        'driverLat': driverLat,
        'driverLng': driverLng,
        'orderUpdates': orderUpdates,
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        items: (json['items'] as List?)
                ?.map((e) => CartItem.fromJson(e))
                .toList() ??
            [],
        subtotal: (json['subtotal'] ?? 0.0).toDouble(),
        tax: (json['tax'] ?? 0.0).toDouble(),
        deliveryFee: (json['deliveryFee'] ?? 0.0).toDouble(),
        total: (json['total'] ?? 0.0).toDouble(),
        deliveryAddress: json['deliveryAddress'] ?? '',
        status: json['status'] ?? 'pending',
        paymentMethod: json['paymentMethod'] ?? 'card',
        isPaymentDone: json['isPaymentDone'] ?? false,
        specialInstructions: json['specialInstructions'] ?? '',
        orderedAt: json['orderedAt'] != null
            ? DateTime.parse(json['orderedAt'])
            : DateTime.now(),
        estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
            ? DateTime.parse(json['estimatedDeliveryTime'])
            : null,
        driverName: json['driverName'],
        driverPhone: json['driverPhone'],
        driverLat: (json['driverLat'] as num?)?.toDouble(),
        driverLng: (json['driverLng'] as num?)?.toDouble(),
        orderUpdates: List<String>.from(json['orderUpdates'] ?? []),
      );
}
