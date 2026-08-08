import 'package:flutter/material.dart';
import 'package:mechanix_widgets/src/theme/variants.dart';
import 'catalog/catalog_theme.dart';

class ThemeToggle extends ChangeNotifier {
  static final ThemeToggle instance = ThemeToggle();

  CatalogThemeStyle _catalogThemeStyle = CatalogThemeStyle.monochrome;
  CatalogThemeStyle get catalogThemeStyle => _catalogThemeStyle;

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  MechanixVariant? _mechanixVariant;
  MechanixVariant? get mechanixVariant => _mechanixVariant;

  void setCatalogThemeStyle(CatalogThemeStyle style) {
    if (_catalogThemeStyle == style) return;
    _catalogThemeStyle = style;
    notifyListeners();
  }

  void setThemeMode(ThemeMode theme) {
    if (_themeMode == theme) return;
    _themeMode = theme;
    notifyListeners();
  }

  void setThemeVariant(MechanixVariant? variant) {
    if (_mechanixVariant == variant) return;
    _mechanixVariant = variant;
    notifyListeners();
  }
}
