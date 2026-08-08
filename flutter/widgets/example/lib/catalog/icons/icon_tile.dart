import 'package:flutter/material.dart';
import '../catalog_icon_data.dart';
import '../catalog_theme.dart';

class IconTile extends StatefulWidget {
  final CatalogIcon catalogIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const IconTile({
    super.key,
    required this.catalogIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<IconTile> createState() => _IconTileState();
}

class _IconTileState extends State<IconTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);
    final isSelected = widget.isSelected;

    final primaryText = tokens.textPrimary;
    final secondaryText = tokens.textSecondary;
    final mutedText = tokens.textMuted;
    final cardBg = tokens.cardBackground;
    final hoverBg = tokens.hoverBackground;
    final border = tokens.border;

    final surfaceColor = isSelected
        ? theme.colorScheme.primaryContainer
        : (_isHovered ? hoverBg : cardBg);

    final borderColor = isSelected
        ? theme.colorScheme.primary
        : (_isHovered ? secondaryText : border);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withAlpha(50),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Stack(
            children: [
              // Selection Badge in top-right corner
              if (isSelected)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),

              // Tile Main Content (Icon + Name + Unicode)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.catalogIcon.iconData,
                      size: 28,
                      color: isSelected || _isHovered
                          ? theme.colorScheme.primary
                          : primaryText,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.catalogIcon.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.catalogIcon.formattedCodePoint,
                      style: TextStyle(
                        fontSize: 10,
                        color: mutedText,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
