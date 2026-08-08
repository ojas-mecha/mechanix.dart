import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../catalog_theme.dart';

class IconSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const IconSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);

    final primaryText = tokens.textPrimary;
    final secondaryText = tokens.textSecondary;
    final inputBg = tokens.inputBackground;
    final border = tokens.border;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): () {
          focusNode.requestFocus();
        },
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true): () {
          focusNode.requestFocus();
        },
        const SingleActivator(LogicalKeyboardKey.slash): () {
          focusNode.requestFocus();
        },
      },
      child: Focus(
        autofocus: false,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  style: TextStyle(fontSize: 13, color: primaryText),
                  decoration: InputDecoration(
                    hintText: 'Search icons...',
                    hintStyle: TextStyle(fontSize: 13, color: secondaryText),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: secondaryText,
                      size: 18,
                    ),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded, size: 16),
                            onPressed: onClear,
                          )
                        : null,
                    filled: true,
                    fillColor: inputBg,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: theme.colorScheme.primary, width: 1.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Filter Options Button
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.tune_rounded, size: 18, color: secondaryText),
                tooltip: 'Filter options',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
