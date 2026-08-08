import 'package:flutter/material.dart';
import '../catalog_icon_data.dart';
import '../catalog_theme.dart';
import '../state/icon_playground_state.dart';
import 'icon_grid.dart';
import 'icon_inspector.dart';
import 'icon_search.dart';

class IconsCatalogPage extends StatefulWidget {
  final IconPlaygroundState playgroundState;
  final bool isDesktop;

  const IconsCatalogPage({
    super.key,
    required this.playgroundState,
    required this.isDesktop,
  });

  @override
  State<IconsCatalogPage> createState() => _IconsCatalogPageState();
}

class _IconsCatalogPageState extends State<IconsCatalogPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<CatalogIcon> get _filteredIcons {
    return catalogIcons.where((icon) {
      final matchesCategory = _selectedCategory == 'All' ||
          icon.category.toLowerCase() == _selectedCategory.toLowerCase();

      final query = _searchQuery.toLowerCase().trim();
      final matchesQuery = query.isEmpty ||
          icon.name.toLowerCase().contains(query) ||
          icon.codePointHex.toLowerCase().contains(query) ||
          icon.formattedCodePoint.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _onIconSelected(BuildContext context, CatalogIcon catalogIcon) {
    widget.playgroundState.selectIcon(catalogIcon);

    if (!widget.isDesktop) {
      // Open modal bottom sheet inspector on mobile devices
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: IconInspector(
                playgroundState: widget.playgroundState,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);

    final primaryText = tokens.textPrimary;
    final secondaryText = tokens.textSecondary;
    final cardBg = tokens.cardBackground;
    final border = tokens.border;

    final icons = _filteredIcons;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page Top Header Section
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title, Badge, and Usage Guide Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Icons',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: border),
                        ),
                        child: Text(
                          '${catalogIcons.length} icons',
                          style: TextStyle(
                            color: secondaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_book_rounded, size: 14),
                    label: const Text('Usage guide',
                        style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryText,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      minimumSize: const Size(0, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: border),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Explore and customize icons from Mechanix UI.',
                style: TextStyle(
                  fontSize: 13,
                  color: secondaryText,
                ),
              ),
              const SizedBox(height: 14),

              // Search Field Component
              IconSearchBar(
                controller: _searchController,
                focusNode: _searchFocusNode,
                searchQuery: _searchQuery,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                onClear: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                },
              ),
              const SizedBox(height: 12),

              // Category Filter Pills Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: catalogIconCategories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? theme.colorScheme.primary : cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : border,
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : primaryText,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Main Icon Grid Content Area
        Expanded(
          child: ValueListenableBuilder<IconPlaygroundConfig>(
            valueListenable: widget.playgroundState,
            builder: (context, config, _) {
              if (icons.isEmpty) {
                return _buildEmptyState(context, secondaryText);
              }
              return IconGrid(
                icons: icons,
                selectedIcon: config.selectedIcon,
                onIconSelected: (icon) => _onIconSelected(context, icon),
              );
            },
          ),
        ),

        // Page Footer Info (Showing count and pagination)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: border),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing 1 to ${icons.length} of ${catalogIcons.length} icons',
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryText,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left_rounded,
                        size: 16, color: secondaryText),
                    onPressed: null,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right_rounded,
                        size: 16, color: secondaryText),
                    onPressed: null,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, Color secondaryText) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 40,
            color: secondaryText,
          ),
          const SizedBox(height: 10),
          Text(
            'No matching icons found',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: secondaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try searching for "wifi", "home", "search" or reset filters.',
            style: TextStyle(
              fontSize: 12,
              color: secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
