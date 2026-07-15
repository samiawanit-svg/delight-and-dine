# Setup Guide - Delight and Dine Flutter App

This guide provides step-by-step instructions to set up and run the Delight and Dine Flutter application.

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Installation](#installation)
3. [Firebase Setup](#firebase-setup)
4. [Running the App](#running-the-app)
5. [Building for Production](#building-for-production)
6. [Troubleshooting](#troubleshooting)

## System Requirements

### Minimum Requirements

- **OS**: Windows 10+, macOS 10.15+, or Linux (Ubuntu 18.04+)
- **RAM**: 8 GB minimum (16 GB recommended)
- **Disk Space**: 10 GB for Flutter SDK and dependencies
- **Flutter**: Version 3.0 or higher
- **Dart**: Version 2.17 or higher (included with Flutter)
- **Android API**: Level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+

### Required Software

#### Windows
- Windows PowerShell 5.0+ or Git Bash
- Android Studio 4.1+
- Android SDK (API level 21+)
- Java Development Kit (JDK) 8+

#### macOS
- Xcode 12.4+
- CocoaPods
- Ruby (usually pre-installed)

#### Linux
- GLIBC 2.15 or higher
- Curl or Wget
- Git

## Installation

### 1. Install Flutter

#### Download Flutter SDK

**Windows/macOS/Linux:**
1. Visit [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. Download the appropriate version for your OS
3. Extract to a desired location (avoid Program Files on Windows)

#### Add Flutter to PATH

**Windows (PowerShell as Administrator):**
```powershell
[Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\path\to\flutter\bin", "User")
# Restart PowerShell
flutter --version
```

**macOS/Linux (Terminal):**
```bash
export PATH="$PATH:$HOME/path/to/flutter/bin"
# Add to ~/.bashrc or ~/.zshrc for persistent PATH
echo 'export PATH="$PATH:$HOME/path/to/flutter/bin"' >> ~/.bashrc
flutter --version
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

This command checks your environment. Ensure:
- ✓ Flutter SDK is detected
- ✓ Android SDK/toolchain is configured
- ✓ Connected devices or emulator

### 3. Setup Android Development

#### Install Android Studio

1. Download [Android Studio](https://developer.android.com/studio)
2. Run installer and follow setup wizard
3. Install Android SDK:
   - Open Android Studio → SDK Manager
   - Install SDK for API level 21+ (Android 5.0+)
   - Install SDK Tools, Build Tools, Emulator

#### Accept Android Licenses

```bash
flutter doctor --android-licenses
```

### 4. Setup iOS Development (macOS only)

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcode-select --reset
sudo gem install cocoapods
pod repo update
```

### 5. Clone the Repository

```bash
git clone https://github.com/samiawanit-svg/delight-and-dine.git
cd delight-and-dine
```

### 6. Get Project Dependencies

```bash
flutter pub get
```

## Firebase Setup

### 1. Create Firebase Project

1. Go to [firebase.google.com](https://firebase.google.com)
2. Click "Go to console"
3. Click "Create a new project"
4. Enter project name: `delight-and-dine`
5. Enable Google Analytics (optional)
6. Create project

### 2. Register App

#### Android

1. In Firebase Console, click "Add app" → "Android"
2. Enter details:
   - **Package name**: `com.delightanddine.app`
   - **App nickname**: Delight and Dine
3. Download `google-services.json`
4. Place in `android/app/` directory
5. Click "Next" and follow configuration steps

#### iOS

1. In Firebase Console, click "Add app" → "iOS"
2. Enter details:
   - **Bundle ID**: `com.delightanddine.app`
   - **App nickname**: Delight and Dine
3. Download `GoogleService-Info.plist`
4. Open `ios/Runner.xcworkspace` in Xcode
5. Drag `GoogleService-Info.plist` to Xcode (Runner folder)
6. Make sure it's added to Runner target

### 3. Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click **Get Started**
3. Enable **Email/Password**:
   - Click **Email/Password**
   - Toggle "Enable"
   - Click "Save"

### 4. Create Firestore Database

1. Go to **Firestore Database**
2. Click **Create Database**
3. Select region (closest to users)
4. Start in **production mode**
5. Click **Create**

### 5. Create Firestore Collections

#### Create `users` Collection

```
Collection: users
Document ID: (auto-generated)
Fields:
  - name: string
  - email: string
  - phone: string
  - profileImage: string
  - addresses: array
  - defaultAddress: string
  - isAdmin: boolean
  - createdAt: timestamp
```

#### Create `menu_items` Collection

```
Collection: menu_items
Document ID: (auto-generated)
Fields:
  - name: string
  - description: string
  - price: number
  - category: string
  - image: string
  - rating: number
  - reviews: number
  - isVegetarian: boolean
  - isSpicy: boolean
  - ingredients: array
  - preparationTime: number
  - isAvailable: boolean
```

#### Create `orders` Collection

```
Collection: orders
Document ID: (auto-generated)
Fields:
  - userId: string
  - items: array
  - subtotal: number
  - tax: number
  - deliveryFee: number
  - total: number
  - deliveryAddress: string
  - status: string
  - paymentMethod: string
  - isPaymentDone: boolean
  - specialInstructions: string
  - orderedAt: timestamp
  - estimatedDeliveryTime: timestamp
  - driverName: string
  - driverPhone: string
  - driverLat: number
  - driverLng: number
  - orderUpdates: array
```

### 6. Set Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection - users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }

    // Menu items - public read, admin write
    match /menu_items/{document=**} {
      allow read: if true;
      allow write: if request.auth.token.admin == true;
    }

    // Orders - users can read/write their own, admin full access
    match /orders/{orderId} {
      allow read, write: if request.auth.uid == resource.data.userId;
      allow read, write: if request.auth.token.admin == true;
    }
  }
}
```

### 7. Update Firebase Configuration

Edit `lib/firebase_options.dart` with your Firebase project credentials:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: 'YOUR_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  databaseURL: 'YOUR_DATABASE_URL',
  storageBucket: 'YOUR_STORAGE_BUCKET',
);
```

You can find these values in:
- Firebase Console → Project Settings → Your Apps ��� Android

## Running the App

### Create Emulator/Device

#### Android Emulator

```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulators --launch emulator_name

# Or use Android Studio's AVD Manager
```

#### iOS Simulator (macOS)

```bash
# Launch iOS Simulator
open -a Simulator

# Or from Xcode
xcode-select --install
```

#### Physical Device

**Android:**
1. Enable Developer Mode (tap Build Number 7 times)
2. Enable USB Debugging
3. Connect via USB
4. Allow USB debugging on device

**iOS:**
1. Connect device via USB
2. Trust the computer on device
3. Xcode will detect device

### Run Development App

```bash
# Run on default device/emulator
flutter run

# Run on specific device
flutter run -d device_id

# Run in release mode
flutter run --release

# Run with verbose logging
flutter run -v
```

### Hot Reload

During development:
- **r**: Hot reload (fast)
- **R**: Hot restart
- **q**: Quit app
- **p**: Toggle performance overlay

## Building for Production

### Android APK

```bash
# Build APK
flutter build apk --release

# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (Recommended for Play Store)

```bash
flutter build appbundle --release

# App Bundle will be at: build/app/outputs/bundle/release/app-release.aab
```

### iOS App

```bash
flutter build ios --release

# Open Xcode for final signing and distribution
open ios/Runner.xcworkspace
```

### Generate Signed APK

1. Create keystore (one-time):
```bash
keytool -genkey -v -keystore ~/delight-and-dine.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias delight_and_dine_key
```

2. Build signed APK:
```bash
flutter build apk --release \
  --keystore=~/delight-and-dine.jks \
  --keystore-password=<password> \
  --key-password=<password> \
  --key-alias=delight_and_dine_key
```

## Troubleshooting

### Flutter Issues

**Problem**: `flutter: command not found`
- **Solution**: Add Flutter to PATH (see Installation section)

**Problem**: Gradle sync fails
- **Solution**: 
  ```bash
  flutter clean
  flutter pub get
  ```

**Problem**: Pod install fails (iOS)
- **Solution**:
  ```bash
  cd ios
  rm -rf Pods
  pod install
  cd ..
  ```

### Firebase Issues

**Problem**: `FirebaseException: Failed to initialize Firebase`
- **Solution**: Ensure google-services.json and GoogleService-Info.plist are correctly placed

**Problem**: Firestore permission denied
- **Solution**: Check Firestore security rules in Firebase Console

**Problem**: Android build fails with Firebase
- **Solution**:
  ```bash
  flutter clean
  cd android
  ./gradlew clean
  cd ..
  flutter pub get
  flutter run
  ```

### Device Issues

**Problem**: Device not detected
- **Solution**:
  ```bash
  flutter devices
  adb devices  # For Android
  ```

**Problem**: USB debugging not working
- **Solution**: 
  - Reinstall USB drivers
  - Toggle USB debugging off/on
  - Restart adb: `adb kill-server && adb start-server`

### Build Issues

**Problem**: `build/outputs/` directory is full
- **Solution**:
  ```bash
  flutter clean
  ```

**Problem**: Out of memory during build
- **Solution**:
  - Increase Gradle heap: Edit `android/gradle.properties`
  - Add: `org.gradle.jvmargs=-Xmx4096m`

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Provider Package Docs](https://pub.dev/packages/provider)
- [Android Development](https://developer.android.com/)
- [iOS Development](https://developer.apple.com/swift/)

## Getting Help

- Check [Flutter Issues](https://github.com/flutter/flutter/issues)
- Search [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- Check [Firebase Support](https://firebase.google.com/support)
- Open an issue on [GitHub](https://github.com/samiawanit-svg/delight-and-dine/issues)

## Next Steps

1. ✅ Complete installation and setup
2. ✅ Configure Firebase
3. ✅ Run the app in development mode
4. 📖 Read [CONTRIBUTING.md](CONTRIBUTING.md) to understand code style
5. 🚀 Start developing!

---

For detailed information, check [README.md](README.md) and [CONTRIBUTING.md](CONTRIBUTING.md).
