# Mechanix Widgets  
**The Flutter Mechanix Apps Widgets & Icons Suite**  

A collection of common and reusable Flutter widgets and icons designed specifically for building **Mechanix Apps** on embedded Linux and desktop.  

---

## 🚀 Getting Started  

### Installation

Add `mechanix_widgets` to your `pubspec.yaml`:

```yaml
dependencies:
  mechanix_widgets:
    path: ../path/to/mechanix_widgets # or git / hosted dependency
```

Import the package in Dart:

```dart
import 'package:mechanix_widgets/mechanix_widgets.dart';
```

---

## 🎨 Icon Usage

`MechanixIcons` provides zero-configuration TTF vector icons:

```dart
Icon(MechanixIcons.home)
Icon(MechanixIcons.wifi, color: Colors.blue, size: 24)
Icon(MechanixIcons.settings)
```

### Icon Font Generator Workflow

To add or update icons:
1. Place SVG files into `assets/icons/svg/`.
2. Run the icon font generator:
   ```bash
   dart run icon_font_generator:generator
   ```

---

## 💻 Run the Example  

To run the example project:

```bash
cd example

# On Embedded Linux (Wayland)
flutter-elinux run -d elinux-wayland

# On Linux Desktop
flutter run -d linux
```
