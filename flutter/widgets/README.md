# Mechanix Widgets (`mechanix_widgets`)

A modern, high-performance reusable UI library for Flutter applications.

## 🚀 Getting Started

Add `mechanix_widgets` to your `pubspec.yaml`:

```yaml
dependencies:
  mechanix_widgets: ^0.0.1
```

Import the primary entry point:

```dart
import 'package:mechanix_widgets/mechanix_widgets.dart';
```

---

## 🎨 Usage Examples

### Applying Theme

```dart
MechanixTheme(
  data: const MechanixThemeData(
    mechanixVariant: MechanixVariant.purple,
    themeMode: ThemeMode.dark,
  ),
  child: MaterialApp(
    home: Scaffold(
      body: Center(
        child: MechanixElevatedButton(
          label: 'Submit',
          onPressed: () {},
        ),
      ),
    ),
  ),
)
```

### Using Custom Icon Font (`MechanixIcons`)

```dart
Icon(MechanixIcons.home)
Icon(MechanixIcons.wifi)
Icon(MechanixIcons.bluetooth)
Icon(MechanixIcons.settings)
Icon(MechanixIcons.search)
Icon(MechanixIcons.close)
```

---

## 🛠️ Icon Font Generator Workflow

Custom SVG icons placed in `assets/icons/svg/` can be compiled into a `.ttf` icon font and updated in Dart code using `icon_font_generator`.

### 1. Configuration in `pubspec.yaml`

Register the configuration in `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: MechanixIcons
      fonts:
        - asset: assets/fonts/MechanixIcons.ttf

icon_font_generator:
  from: assets/icons/svg
  out_font: assets/fonts/MechanixIcons.ttf
  out_flutter: lib/src/icons/mechanix_icons.dart
  class_name: MechanixIcons
  font_family: MechanixIcons
  package: mechanix_widgets
```

### 2. Generation Terminal Command

Whenever you add or update `.svg` icons in `assets/icons/svg/`, execute the following terminal command from the package root directory:

```bash
dart run icon_font_generator:generator assets/icons/svg assets/fonts/MechanixIcons.ttf
```

This updates `assets/fonts/MechanixIcons.ttf` and generates the updated static `IconData` fields in `lib/src/icons/mechanix_icons.dart`.

---

## 🧪 Testing & Verification

To run unit and widget tests:

```bash
flutter test
```

To run static analysis:

```bash
flutter analyze
```
