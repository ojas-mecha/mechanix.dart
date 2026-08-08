import 'package:flutter/widgets.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

/// Data model representing an icon entry in the design system catalog.
class CatalogIcon {
  final String name;
  final IconData iconData;
  final String codePointHex;
  final String category;

  const CatalogIcon({
    required this.name,
    required this.iconData,
    required this.codePointHex,
    this.category = 'General',
  });

  /// Returns the codepoint in standard Unicode format (e.g., U+E002)
  String get formattedCodePoint =>
      'U+${codePointHex.toUpperCase().padLeft(4, '0')}';

  /// Returns the codepoint as a hex literal string (e.g., 0xE002)
  String get hexLiteral => '0x${codePointHex.toUpperCase().padLeft(4, '0')}';
}

/// Dynamic source of truth for icons cataloged from MechanixIcons.
final List<CatalogIcon> catalogIcons = [
  CatalogIcon(
    name: 'wifi',
    iconData: MechanixIcons.wifi,
    codePointHex: MechanixIcons.wifi.codePoint.toRadixString(16),
    category: 'Connectivity',
  ),
  CatalogIcon(
    name: 'home',
    iconData: MechanixIcons.home,
    codePointHex: MechanixIcons.home.codePoint.toRadixString(16),
    category: 'Navigation',
  ),
  CatalogIcon(
    name: 'search',
    iconData: MechanixIcons.search,
    codePointHex: MechanixIcons.search.codePoint.toRadixString(16),
    category: 'Actions',
  ),
  CatalogIcon(
    name: 'settings',
    iconData: MechanixIcons.settings,
    codePointHex: MechanixIcons.settings.codePoint.toRadixString(16),
    category: 'Device',
  ),
  CatalogIcon(
    name: 'close',
    iconData: MechanixIcons.close,
    codePointHex: MechanixIcons.close.codePoint.toRadixString(16),
    category: 'Actions',
  ),
  CatalogIcon(
    name: 'mecha',
    iconData: MechanixIcons.mecha,
    codePointHex: MechanixIcons.mecha.codePoint.toRadixString(16),
    category: 'Brand',
  ),
  CatalogIcon(
    name: 'bluetooth',
    iconData: MechanixIcons.bluetooth,
    codePointHex: MechanixIcons.bluetooth.codePoint.toRadixString(16),
    category: 'Connectivity',
  ),
];

/// List of unique categories available in the icon set.
List<String> get catalogIconCategories {
  final categories = <String>{'All'};
  for (final icon in catalogIcons) {
    categories.add(icon.category);
  }
  return categories.toList();
}
