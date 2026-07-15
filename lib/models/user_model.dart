class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final List<String> addresses;
  final String defaultAddress;
  final bool isAdmin;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage = '',
    this.addresses = const [],
    this.defaultAddress = '',
    this.isAdmin = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profileImage': profileImage,
        'addresses': addresses,
        'defaultAddress': defaultAddress,
        'isAdmin': isAdmin,
        'createdAt': createdAt.toIso8601String(),
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        profileImage: json['profileImage'] ?? '',
        addresses: List<String>.from(json['addresses'] ?? []),
        defaultAddress: json['defaultAddress'] ?? '',
        isAdmin: json['isAdmin'] ?? false,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
      );
}
