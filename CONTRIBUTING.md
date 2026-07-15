# Contributing to Delight and Dine

Thank you for your interest in contributing to the Delight and Dine Flutter application! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others in the community
- Report inappropriate behavior appropriately

## Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK
- Git
- Firebase account (for testing)
- Android Studio/Xcode with emulators

### Setting Up Development Environment

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/delight-and-dine.git
   cd delight-and-dine
   ```

3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/samiawanit-svg/delight-and-dine.git
   ```

4. Install dependencies:
   ```bash
   flutter pub get
   ```

5. Set up Firebase for your testing environment

## Development Workflow

### Creating a Branch

```bash
git checkout -b feature/your-feature-name
# or for bug fixes
git checkout -b bugfix/bug-description
```

### Branch Naming Convention

- `feature/feature-name` - New features
- `bugfix/bug-description` - Bug fixes
- `docs/documentation-update` - Documentation updates
- `refactor/refactor-description` - Code refactoring
- `test/test-description` - Test additions

### Code Style Guide

#### Formatting
- Use 2 spaces for indentation
- Run `flutter format` before committing
- Line length: 80 characters (soft limit), 120 (hard limit)

#### Naming Conventions

**Files and Directories**
- Use snake_case for file names: `menu_item_card.dart`
- Group related files in directories

**Classes**
- Use PascalCase: `MenuItemCard`, `AuthProvider`
- Widget classes should end with "Widget": `CustomSearchBarWidget`
- Provider classes should end with "Provider": `AuthProvider`

**Variables and Functions**
- Use camelCase: `itemCount`, `fetchMenuItems()`
- Private members start with underscore: `_privateMethod()`
- Constants use camelCase with `const` keyword

**Constants**
```dart
const double spacing16 = 16.0;
const String appName = 'Delight and Dine';
```

#### Documentation
- Add documentation comments for public APIs
- Use `///` for public documentation
- Use `//` for inline comments

```dart
/// Adds an item to the shopping cart.
/// 
/// [item] The menu item to add
/// [quantity] The number of items (default: 1)
void addItem(MenuItem item, {int quantity = 1}) {
  // Implementation
}
```

### Coding Best Practices

1. **State Management**
   - Use Provider for state management
   - Keep providers focused on single responsibility
   - Avoid nested providers when possible

2. **Widget Structure**
   ```dart
   class MyWidget extends StatelessWidget {
     const MyWidget({Key? key}) : super(key: key);

     @override
     Widget build(BuildContext context) {
       return Container();
     }
   }
   ```

3. **Error Handling**
   ```dart
   try {
     // code
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error: $e')),
     );
   }
   ```

4. **Asset Management**
   - Store images in `assets/images/`
   - Store icons in `assets/icons/`
   - Update `pubspec.yaml` when adding new assets

5. **Security**
   - Never hardcode API keys or secrets
   - Use Firebase rules for data security
   - Validate all user inputs
   - Use HTTPS for all API calls

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/providers/auth_provider_test.dart
```

### Linting and Analysis

```bash
# Run analyzer
flutter analyze

# Format code
flutter format .

# Fix formatting issues
dart fix --apply
```

## Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that don't affect code meaning
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Code change that improves performance
- `test`: Adding missing or updating tests
- `chore`: Changes to build process or dependencies

### Examples

```
feat(auth): add fingerprint authentication

Implement biometric authentication using local_auth package.
Supports both Android and iOS platforms.

Fixes #123
```

```
fix(cart): prevent negative quantities

Add validation to prevent cart items from having negative quantities.
Now enforces minimum quantity of 1.
```

## Pull Request Process

### Before Submitting

1. Update your branch with latest upstream:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. Run all checks:
   ```bash
   flutter analyze
   flutter format .
   flutter test
   ```

3. Commit your changes with proper messages

### Submitting PR

1. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

2. Create Pull Request on GitHub

3. Fill in the PR template with:
   - **Description**: What does this PR do?
   - **Related Issues**: Link to related issues (#123)
   - **Type**: Feature/Bug Fix/Documentation
   - **Testing**: How was this tested?
   - **Screenshots**: If UI changes (optional)
   - **Checklist**: Follow the PR checklist

### PR Checklist

```markdown
- [ ] Code follows the style guide
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings/errors in analysis
- [ ] Tests added/updated
- [ ] All tests passing
- [ ] Screenshots attached (if UI changes)
```

### Review Process

- Maintainers will review your PR
- Respond to review comments promptly
- Request changes if needed
- Once approved, your PR will be merged

## Reporting Issues

### Bug Reports

Include:
- Clear description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots/videos if applicable
- Device/OS information
- Flutter version: `flutter --version`

### Feature Requests

Include:
- Clear description of the feature
- Use cases and benefits
- Possible implementation approach
- Examples or mockups

## Project Structure Conventions

```
lib/
├── main.dart                  # Entry point
├── firebase_options.dart      # Firebase config
├── theme/                     # App theming
├── models/                    # Data models
├── providers/                 # State management
├── screens/                   # UI screens
│   ├── auth/                 # Authentication screens
│   └── ...
└── widgets/                   # Reusable widgets
```

## Documentation

- Update README.md for major changes
- Document complex functions
- Add comments for non-obvious code
- Update CHANGELOG.md

## Performance Considerations

- Use const constructors when possible
- Avoid rebuilding unnecessarily
- Use ListView.builder for long lists
- Cache network images
- Optimize images before adding

## Security Guidelines

- Never commit credentials
- Use environment variables for secrets
- Validate user input
- Implement proper authentication
- Use secure Firebase rules

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Provider Package](https://pub.dev/packages/provider)
- [Firebase Documentation](https://firebase.google.com/docs)

## Questions or Need Help?

- Open an issue for discussions
- Check existing issues first
- Join our community channels
- Email: samiawan.it@gmail.com

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Delight and Dine! 🎉
