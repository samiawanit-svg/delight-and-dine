# Environment Configuration Guide

This document explains the environment setup for Delight and Dine.

## Environment Files

The project uses environment files for configuration management:

- `.env.example` - Template for environment variables (commit to repo)
- `.env.local` - Local development overrides (gitignore)
- `.env.development` - Development environment (optional)
- `.env.production` - Production environment (optional)

## Setup

1. Copy `.env.example` to `.env.local`:
   ```bash
   cp .env.example .env.local
   ```

2. Edit `.env.local` with your local configuration

3. Never commit `.env.local` or files containing secrets

## Firebase Configuration

Update `lib/firebase_options.dart` with your Firebase project details:

### Android

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: 'YOUR_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'your-project-id',
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',
);
```

### iOS

```dart
static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_IOS_API_KEY',
  appId: 'YOUR_IOS_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'your-project-id',
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',
);
```

### Web

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_WEB_API_KEY',
  appId: 'YOUR_WEB_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'your-project-id',
  authDomain: 'your-project-id.firebaseapp.com',
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',
  measurementId: 'YOUR_MEASUREMENT_ID',
);
```

## Android Configuration

### google-services.json

1. Download from Firebase Console
2. Place in `android/app/` directory
3. Ensure it's in `.gitignore`

### build.gradle

```gradle
Android Gradle Plugin: 7.0+
Gradle Version: 7.0+
MinimumSdkVersion: 21
TargetSdkVersion: 33+
```

## iOS Configuration

### GoogleService-Info.plist

1. Download from Firebase Console
2. Add to Xcode (Runner target)
3. Ensure it's in `.gitignore`

### Podfile

```ruby
platform :ios, '11.0'
```

## Development vs Production

### Development
- Use test Firebase project
- Enable verbose logging
- Use development signing certificates
- Test with staging data

### Production
- Use production Firebase project
- Minimize logging
- Use production signing certificates
- Enable app signing and security

## Sensitive Information

Never commit:
- API keys
- Firebase credentials
- Signing certificates
- Private keys
- Database passwords
- Third-party service credentials

Always use:
- Environment variables
- Firebase rules for security
- Secure key management
- .gitignore for secrets

## Documentation

For detailed setup instructions, see [SETUP.md](SETUP.md).
