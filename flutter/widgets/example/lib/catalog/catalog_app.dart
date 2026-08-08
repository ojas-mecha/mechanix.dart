import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

import 'catalog_models.dart';
import 'catalog_shell.dart';
import 'icons/icon_catalog_page.dart';
import 'state/icon_playground_state.dart';

class CatalogAppShell extends StatefulWidget {
  const CatalogAppShell({super.key});

  @override
  State<CatalogAppShell> createState() => _CatalogAppShellState();
}

class _CatalogAppShellState extends State<CatalogAppShell> {
  final IconPlaygroundState _iconPlaygroundState = IconPlaygroundState();
  late final List<CatalogCategory> _catalogCategories;
  late CatalogItem _selectedItem;

  @override
  void initState() {
    super.initState();
    _catalogCategories = [
      CatalogCategory(
        name: 'COMPONENTS',
        items: [
          CatalogItem(
            id: 'icons',
            title: 'Icons',
            description: 'Explore and customize icons from Mechanix UI.',
            icon: MechanixIcons.wifi,
            builder: (context, isDesktop) => IconsCatalogPage(
              playgroundState: _iconPlaygroundState,
              isDesktop: isDesktop,
            ),
          ),
        ],
      ),
    ];
    _selectedItem = _catalogCategories.first.items.first;
  }

  @override
  void dispose() {
    _iconPlaygroundState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CatalogShell(
      playgroundState: _iconPlaygroundState,
      categories: _catalogCategories,
      selectedItem: _selectedItem,
      onItemSelected: (item) {
        setState(() {
          _selectedItem = item;
        });
      },
    );
  }
}
