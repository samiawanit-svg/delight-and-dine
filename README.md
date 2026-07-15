# Delight and Dine - Flutter Restaurant Order Taking App

A complete Flutter mobile application for food ordering and delivery at your restaurant "Delight and Dine". This app provides customers with a seamless experience to browse menu items, place orders, track deliveries, and manage their profiles.

## Features

### 🔐 Authentication
- User registration and login
- Secure password handling
- User profile management
- Firebase Authentication integration

### 🍽️ Menu Management
- Browse restaurant menu with categories
- Search functionality for quick food discovery
- Detailed item information with ratings and reviews
- Vegetarian indicators and ingredient lists
- Preparation time information

### 🛒 Shopping Cart
- Add/remove items from cart
- Adjust item quantities
- Add special requests/instructions
- Real-time cart total calculation
- Tax and delivery fee calculation

### 📦 Order Management
- Easy checkout process
- Multiple delivery address support
- Various payment methods (Card, UPI, Cash)
- Special cooking instructions
- Order confirmation and tracking

### 📍 Order Tracking
- Real-time order status updates
- Visual status timeline
- Delivery address display
- Estimated delivery time
- Driver information and contact

### 👤 User Profile
- View user information
- Manage saved addresses
- Order history
- Account settings
- Help & support

### 🎨 UI/UX Features
- Modern and intuitive design
- Bottom navigation for easy access
- Smooth animations and transitions
- Responsive layout
- Dark-friendly theme colors

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── theme/
│   └── app_theme.dart       # App theming
├── models/
│   ├── user_model.dart      # User data model
│   ├── menu_item_model.dart # Menu item model
│   ├── cart_item_model.dart # Cart item model
│   └── order_model.dart     # Order data model
├── providers/
│   ├── auth_provider.dart   # Authentication logic
│   ├── menu_provider.dart   # Menu management
│   ├── cart_provider.dart   # Shopping cart
│   └── order_provider.dart  # Order management
├── screens/
│   ├── splash_screen.dart           # Splash screen
│   ├── auth/
│   │   ├── login_screen.dart        # User login
│   │   └── signup_screen.dart       # User registration
│   ├── home_screen.dart             # Home/menu browse
│   ├── cart_screen.dart             # Shopping cart view
│   ├── checkout_screen.dart         # Order checkout
│   ├── order_tracking_screen.dart   # Track orders
│   ├── profile_screen.dart          # User profile
│   ├── search_screen.dart           # Search functionality
│   ├── orders_screen.dart           # Order history
│   ├── item_detail_screen.dart      # Item details
│   ├── bottom_nav_screen.dart       # Main navigation
│   └── no_route.dart                # 404 page
└── widgets/
    ├── menu_item_card.dart          # Menu item card widget
    └── custom_search_bar.dart       # Search bar widget
```

## Dependencies

### State Management
- **provider**: For state management and dependency injection

### Backend & Database
- **firebase_core**: Firebase initialization
- **firebase_auth**: User authentication
- **cloud_firestore**: Real-time database
- **firebase_storage**: Image and file storage
- **firebase_messaging**: Push notifications

### UI & Design
- **google_fonts**: Beautiful fonts
- **cached_network_image**: Efficient image caching

### Payment & Location
- **stripe_flutter**: Credit card payments
- **razorpay_flutter**: Indian payment gateway
- **geolocator**: GPS location services
- **google_maps_flutter**: Map integration

### Local Storage
- **shared_preferences**: Local data persistence
- **image_picker**: Image selection from device

### Other
- **intl**: Internationalization
- **table_calendar**: Calendar widget
- **charts_flutter**: Analytics charts
- **uuid**: Unique ID generation
- **connectivity_plus**: Network connectivity check

## Firebase Setup

1. Create a Firebase project at [firebase.google.com](https://firebase.google.com)
2. Enable Firebase Authentication (Email/Password)
3. Create a Cloud Firestore database
4. Enable Firebase Storage
5. Configure Firebase Messaging for notifications
6. Download google-services.json (Android) and GoogleService-Info.plist (iOS)
7. Update `lib/firebase_options.dart` with your project credentials

## Database Structure

### Firestore Collections

#### users
```
{
  id: string (user ID)
  name: string
  email: string
  phone: string
  profileImage: string (URL)
  addresses: array of strings
  defaultAddress: string
  isAdmin: boolean
  createdAt: timestamp
}
```

#### menu_items
```
{
  id: string
  name: string
  description: string
  price: number
  category: string
  image: string (URL)
  rating: number
  reviews: number
  isVegetarian: boolean
  isSpicy: boolean
  ingredients: array of strings
  preparationTime: number (minutes)
  isAvailable: boolean
}
```

#### orders
```
{
  id: string (order ID)
  userId: string
  items: array of cart items
  subtotal: number
  tax: number
  deliveryFee: number
  total: number
  deliveryAddress: string
  status: string (pending, confirmed, preparing, ready, out_for_delivery, delivered, cancelled)
  paymentMethod: string (card, upi, cash)
  isPaymentDone: boolean
  specialInstructions: string
  orderedAt: timestamp
  estimatedDeliveryTime: timestamp
  driverName: string
  driverPhone: string
  driverLat: number
  driverLng: number
  orderUpdates: array of strings
}
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Android Studio or Xcode
- Firebase account
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/samiawanit-svg/delight-and-dine.git
cd delight-and-dine
```

2. Get dependencies
```bash
flutter pub get
```

3. Configure Firebase
   - Download google-services.json and GoogleService-Info.plist
   - Place them in the appropriate directories
   - Update firebase_options.dart

4. Run the app
```bash
flutter run
```

## Building for Production

### Android
```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## App Features Overview

### Customer Features
- 👤 User authentication and profile management
- 🔍 Search and filter menu items by category
- ⭐ View ratings, reviews, and item details
- 🛒 Add items to cart with special requests
- 💳 Multiple payment options
- 📦 Real-time order tracking
- 📍 Delivery address management
- 📱 Order history and reorder

### Technical Highlights
- ✅ State management with Provider
- ✅ Firebase backend integration
- ✅ Real-time database updates
- ✅ Responsive UI design
- ✅ Image caching and optimization
- ✅ Error handling and validation
- ✅ Smooth animations
- ✅ Local data persistence

## Future Enhancements

- Push notifications for order updates
- Rating and review system
- Wallet and loyalty points
- Admin dashboard
- Analytics and reporting
- In-app chat support
- Video tutorials
- Multiple language support

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email samiawan.it@gmail.com or open an issue in the repository.

## Author

**Samia Wan** - [GitHub Profile](https://github.com/samiawanit-svg)

---

Made with ❤️ for Delight and Dine Restaurant
