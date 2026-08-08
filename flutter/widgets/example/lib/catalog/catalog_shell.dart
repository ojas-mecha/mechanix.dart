import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

import '../theme_toggle.dart';
import 'catalog_models.dart';
import 'catalog_navigation.dart';
import 'catalog_theme.dart';
import 'icons/icon_inspector.dart';
import 'state/icon_playground_state.dart';

class CatalogShell extends StatefulWidget {
  final IconPlaygroundState playgroundState;
  final List<CatalogCategory> categories;
  final CatalogItem selectedItem;
  final ValueChanged<CatalogItem> onItemSelected;

  const CatalogShell({
    super.key,
    required this.playgroundState,
    required this.categories,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<CatalogShell> createState() => _CatalogShellState();
}

class _CatalogShellState extends State<CatalogShell> {
  final TextEditingController _globalSearchController = TextEditingController();

  @override
  void dispose() {
    _globalSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = CatalogColors.of(context);
    final themeToggle = ThemeToggle.instance;
    final currentThemeStyle = themeToggle.catalogThemeStyle;
    final currentMechanixVariant = themeToggle.mechanixVariant;
    final currentThemeMode = themeToggle.themeMode;

    final bg = tokens.background;
    final panelBg = tokens.panelBackground;
    final border = tokens.border;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1000;
        final isTablet = constraints.maxWidth >= 640 && !isDesktop;

        return Scaffold(
          backgroundColor: bg,
          appBar: _buildTopHeader(
            context,
            showDrawerButton: !isDesktop && !isTablet,
            currentThemeStyle: currentThemeStyle,
            onThemeStyleChanged: (style) =>
                themeToggle.setCatalogThemeStyle(style),
            currentMechanixVariant: currentMechanixVariant,
            onMechanixVariantChanged: (variant) =>
                themeToggle.setThemeVariant(variant),
            currentThemeMode: currentThemeMode,
            onThemeModeChanged: (mode) => themeToggle.setThemeMode(mode),
          ),
          drawer: (!isDesktop && !isTablet)
              ? Drawer(
                  backgroundColor: panelBg,
                  child: CatalogNavigationSidebar(
                    categories: widget.categories,
                    selectedItem: widget.selectedItem,
                    onItemSelected: (item) {
                      widget.onItemSelected(item);
                      Navigator.of(context).pop();
                    },
                    currentThemeMode: currentThemeMode,
                    onThemeModeChanged: (mode) =>
                        themeToggle.setThemeMode(mode),
                  ),
                )
              : null,
          body: Row(
            children: [
              // 1. Sidebar Navigation (Desktop & Tablet)
              if (isDesktop || isTablet)
                SizedBox(
                  width: isDesktop ? 220 : 180,
                  child: Container(
                    decoration: BoxDecoration(
                      color: panelBg,
                      border: Border(
                        right: BorderSide(color: border),
                      ),
                    ),
                    child: CatalogNavigationSidebar(
                      categories: widget.categories,
                      selectedItem: widget.selectedItem,
                      onItemSelected: widget.onItemSelected,
                      currentThemeMode: currentThemeMode,
                      onThemeModeChanged: (mode) =>
                          themeToggle.setThemeMode(mode),
                    ),
                  ),
                ),

              // 2. Main Catalog Content Stage (Icons Catalog Page)
              Expanded(
                child: Container(
                  color: bg,
                  child: widget.selectedItem
                      .builder(context, isDesktop || isTablet),
                ),
              ),

              // 3. Property Inspector & Live Preview (Desktop & Tablet)
              if (isDesktop || isTablet)
                SizedBox(
                  width: isDesktop ? 320 : 280,
                  child: Container(
                    decoration: BoxDecoration(
                      color: panelBg,
                      border: Border(
                        left: BorderSide(color: border),
                      ),
                    ),
                    child: IconInspector(
                      playgroundState: widget.playgroundState,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildTopHeader(
    BuildContext context, {
    required bool showDrawerButton,
    required CatalogThemeStyle currentThemeStyle,
    required ValueChanged<CatalogThemeStyle> onThemeStyleChanged,
    required MechanixVariant? currentMechanixVariant,
    required ValueChanged<MechanixVariant?> onMechanixVariantChanged,
    required ThemeMode currentThemeMode,
    required ValueChanged<ThemeMode> onThemeModeChanged,
  }) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);

    final headerBg = tokens.background;
    final primaryText = tokens.textPrimary;
    final secondaryText = tokens.textSecondary;
    final inputBg = tokens.inputBackground;
    final border = tokens.border;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: headerBg,
      centerTitle: false,
      titleSpacing: 16,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: border, height: 1),
      ),
      leading: showDrawerButton
          ? Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: primaryText),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Row(
        children: [
          // Logo Badge (Theme primary square with onPrimary Mecha icon)
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                MechanixIcons.mecha,
                size: 28,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Mechanix UI',
            style: TextStyle(
              color: primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: tokens.cardBackground,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: border),
            ),
            child: Text(
              'v1.0.0',
              style: TextStyle(
                color: secondaryText,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Global Search Bar Input
          Expanded(
            child: Container(
              height: 34,
              constraints: const BoxConstraints(maxWidth: 420),
              child: TextField(
                controller: _globalSearchController,
                style: TextStyle(fontSize: 12, color: primaryText),
                decoration: InputDecoration(
                  hintText: 'Search components...',
                  hintStyle: TextStyle(fontSize: 12, color: secondaryText),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 16,
                    color: secondaryText,
                  ),
                  suffixIcon: UnconstrainedBox(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: tokens.cardBackground,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: border),
                      ),
                      child: Text(
                        '⌘K',
                        style: TextStyle(
                          fontSize: 10,
                          color: secondaryText,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: inputBg,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        // Theme Style Selector Dropdown
        PopupMenuButton<CatalogThemeStyle>(
          initialValue: currentThemeStyle,
          onSelected: onThemeStyleChanged,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: inputBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  size: 14,
                  color: primaryText,
                ),
                const SizedBox(width: 6),
                Text(
                  currentThemeStyle == CatalogThemeStyle.monochrome
                      ? 'Monochrome'
                      : 'Indigo',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryText,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: secondaryText,
                ),
              ],
            ),
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: CatalogThemeStyle.monochrome,
              child: Row(
                children: [
                  Icon(Icons.contrast_rounded, size: 16),
                  SizedBox(width: 8),
                  Text('Monochrome', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: CatalogThemeStyle.indigo,
              child: Row(
                children: [
                  Icon(Icons.color_lens_outlined, size: 16),
                  SizedBox(width: 8),
                  Text('Indigo', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),

        // Mechanix Variant Selector Dropdown
        PopupMenuButton<_VariantOption>(
          initialValue: _VariantOption(currentMechanixVariant),
          onSelected: (option) => onMechanixVariantChanged(option.variant),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: inputBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                if (currentMechanixVariant != null)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: currentMechanixVariant.color,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  Icon(
                    Icons.circle_outlined,
                    size: 12,
                    color: secondaryText,
                  ),
                const SizedBox(width: 6),
                Text(
                  currentMechanixVariant?.name ?? 'Default',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryText,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: secondaryText,
                ),
              ],
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<_VariantOption>(
              value: const _VariantOption(null),
              child: Row(
                children: [
                  Icon(Icons.circle_outlined, size: 14, color: secondaryText),
                  const SizedBox(width: 8),
                  const Text('Default', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            ...MechanixVariant.values.map((variant) {
              return PopupMenuItem<_VariantOption>(
                value: _VariantOption(variant),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: variant.color,
                        shape: BoxShape.circle,
                        border: Border.all(color: border, width: 0.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      variant.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        const SizedBox(width: 8),

        // Brightness Theme Mode Selector Dropdown
        PopupMenuButton<ThemeMode>(
          initialValue: currentThemeMode,
          onSelected: onThemeModeChanged,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: inputBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                Icon(
                  currentThemeMode == ThemeMode.dark
                      ? Icons.nightlight_round
                      : currentThemeMode == ThemeMode.light
                          ? Icons.wb_sunny_outlined
                          : Icons.desktop_windows_outlined,
                  size: 14,
                  color: primaryText,
                ),
                const SizedBox(width: 6),
                Text(
                  currentThemeMode == ThemeMode.dark
                      ? 'Dark'
                      : currentThemeMode == ThemeMode.light
                          ? 'Light'
                          : 'System',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryText,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: secondaryText,
                ),
              ],
            ),
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(Icons.wb_sunny_outlined, size: 16),
                  SizedBox(width: 8),
                  Text('Light', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(Icons.nightlight_round, size: 16),
                  SizedBox(width: 8),
                  Text('Dark', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(Icons.desktop_windows_outlined, size: 16),
                  SizedBox(width: 8),
                  Text('System', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),

        // Settings Action Button
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings_outlined, size: 18, color: secondaryText),
          tooltip: 'Settings',
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}

@immutable
class _VariantOption {
  final MechanixVariant? variant;
  const _VariantOption(this.variant);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _VariantOption &&
          runtimeType == other.runtimeType &&
          variant == other.variant;

  @override
  int get hashCode => variant.hashCode;
}
