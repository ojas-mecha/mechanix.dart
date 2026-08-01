import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

class ThemeToggle extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  MechanixVariant? _mechanixVariant = MechanixVariant.blue;
  MechanixVariant? get mechanixVariant => _mechanixVariant;

  void setThemeMode(ThemeMode theme) {
    if (_themeMode == theme) return;
    _themeMode = theme;
    notifyListeners();
  }

  void setThemeVariant(MechanixVariant variant) {
    if (_mechanixVariant == variant) return;
    _mechanixVariant = variant;
    notifyListeners();
  }
}
