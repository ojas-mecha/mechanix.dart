import 'package:flutter/material.dart';
import 'catalog_models.dart';
import 'catalog_theme.dart';

class CatalogNavigationSidebar extends StatefulWidget {
  final List<CatalogCategory> categories;
  final CatalogItem selectedItem;
  final ValueChanged<CatalogItem> onItemSelected;
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const CatalogNavigationSidebar({
    super.key,
    required this.categories,
    required this.selectedItem,
    required this.onItemSelected,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<CatalogNavigationSidebar> createState() =>
      _CatalogNavigationSidebarState();
}

class _CatalogNavigationSidebarState extends State<CatalogNavigationSidebar> {
  bool _isFoundationExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);

    final primaryText = tokens.textPrimary;
    final secondaryText = tokens.textSecondary;
    final mutedText = tokens.textMuted;
    final border = tokens.border;

    return Column(
      children: [
        // Navigation items list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            children: [
              // CATALOG Section Label
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 12),
                child: Text(
                  'CATALOG',
                  style: TextStyle(
                    color: mutedText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                ),
              ),

              // Foundation Collapsible Section
              InkWell(
                onTap: () {
                  setState(() {
                    _isFoundationExpanded = !_isFoundationExpanded;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Foundation',
                        style: TextStyle(
                          color: primaryText,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _isFoundationExpanded
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.chevron_right_rounded,
                        size: 16,
                        color: secondaryText,
                      ),
                    ],
                  ),
                ),
              ),
              if (_isFoundationExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
                  child: Text(
                    'No foundation items',
                    style: TextStyle(
                      color: mutedText,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Components Section Label
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 8),
                child: Text(
                  'Components',
                  style: TextStyle(
                    color: mutedText,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),

              // Components List Items (Currently ONLY Icons)
              for (final category in widget.categories)
                for (final item in category.items) ...[
                  _buildNavItem(context, item, primaryText, secondaryText),
                ],

              const SizedBox(height: 32),

              // GitHub Banner Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tokens.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_outline_rounded,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Star on GitHub',
                            style: TextStyle(
                              color: primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: secondaryText,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Help us improve Mechanix UI',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Footer Section: Light/Dark/System Theme Selector + Version
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: border,
              ),
            ),
          ),
          child: Column(
            children: [
              // Segmented theme toggle row
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: tokens.inputBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildThemeOptionButton(
                        context,
                        icon: Icons.wb_sunny_outlined,
                        mode: ThemeMode.light,
                        isSelected: widget.currentThemeMode == ThemeMode.light,
                      ),
                    ),
                    Expanded(
                      child: _buildThemeOptionButton(
                        context,
                        icon: Icons.nightlight_round,
                        mode: ThemeMode.dark,
                        isSelected: widget.currentThemeMode == ThemeMode.dark,
                      ),
                    ),
                    Expanded(
                      child: _buildThemeOptionButton(
                        context,
                        icon: Icons.desktop_windows_outlined,
                        mode: ThemeMode.system,
                        isSelected: widget.currentThemeMode == ThemeMode.system,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: secondaryText,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                  Icon(
                    Icons.wb_sunny_outlined,
                    size: 14,
                    color: secondaryText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    CatalogItem item,
    Color primaryText,
    Color secondaryText,
  ) {
    final isSelected = item.id == widget.selectedItem.id;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected ? theme.colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => widget.onItemSelected(item),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.onPrimary.withAlpha(40)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    item.icon,
                    size: 16,
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : secondaryText,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                    color:
                        isSelected ? theme.colorScheme.onPrimary : primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOptionButton(
    BuildContext context, {
    required IconData icon,
    required ThemeMode mode,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);

    return InkWell(
      onTap: () => widget.onThemeModeChanged(mode),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 14,
          color:
              isSelected ? theme.colorScheme.onPrimary : tokens.textSecondary,
        ),
      ),
    );
  }
}
