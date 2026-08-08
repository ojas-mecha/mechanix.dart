import 'package:flutter/material.dart';
import '../catalog_icon_data.dart';
import 'icon_tile.dart';

class IconGrid extends StatelessWidget {
  final List<CatalogIcon> icons;
  final CatalogIcon selectedIcon;
  final ValueChanged<CatalogIcon> onIconSelected;

  const IconGrid({
    super.key,
    required this.icons,
    required this.selectedIcon,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 130,
        childAspectRatio: 0.92,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final iconItem = icons[index];
        final isSelected = iconItem.name == selectedIcon.name;

        return IconTile(
          catalogIcon: iconItem,
          isSelected: isSelected,
          onTap: () => onIconSelected(iconItem),
        );
      },
    );
  }
}
