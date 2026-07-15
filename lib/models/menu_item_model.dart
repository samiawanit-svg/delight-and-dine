class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rating;
  final int reviews;
  final bool isVegetarian;
  final bool isSpicy;
  final List<String> ingredients;
  final int preparationTime; // in minutes
  final bool isAvailable;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.rating = 0.0,
    this.reviews = 0,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.ingredients = const [],
    this.preparationTime = 15,
    this.isAvailable = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'image': image,
        'rating': rating,
        'reviews': reviews,
        'isVegetarian': isVegetarian,
        'isSpicy': isSpicy,
        'ingredients': ingredients,
        'preparationTime': preparationTime,
        'isAvailable': isAvailable,
      };

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        price: (json['price'] ?? 0.0).toDouble(),
        category: json['category'] ?? '',
        image: json['image'] ?? '',
        rating: (json['rating'] ?? 0.0).toDouble(),
        reviews: json['reviews'] ?? 0,
        isVegetarian: json['isVegetarian'] ?? false,
        isSpicy: json['isSpicy'] ?? false,
        ingredients: List<String>.from(json['ingredients'] ?? []),
        preparationTime: json['preparationTime'] ?? 15,
        isAvailable: json['isAvailable'] ?? true,
      );
}
