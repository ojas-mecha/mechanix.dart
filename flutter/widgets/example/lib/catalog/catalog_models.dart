import 'package:flutter/material.dart';

typedef CatalogShowcaseBuilder = Widget Function(
  BuildContext context,
  bool isDesktop,
);

/// Group of items under a section (e.g. Foundation, Components)
class CatalogCategory {
  final String name;
  final List<CatalogItem> items;
  final bool isExpandable;

  const CatalogCategory({
    required this.name,
    required this.items,
    this.isExpandable = false,
  });
}

/// Individual item in the catalog (e.g. Icons)
class CatalogItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final CatalogShowcaseBuilder builder;

  const CatalogItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.builder,
  });
}
