import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../catalog_theme.dart';
import '../state/icon_playground_state.dart';

class IconInspector extends StatelessWidget {
  final IconPlaygroundState playgroundState;

  const IconInspector({
    super.key,
    required this.playgroundState,
  });

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text('Copied $label to clipboard!'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = CatalogColors.of(context);

    final primaryText = tokens.textPrimary;
    final secondaryText = tokens.textSecondary;
    final mutedText = tokens.textMuted;
    final cardBg = tokens.cardBackground;
    final inputBg = tokens.inputBackground;
    final border = tokens.border;

    return ValueListenableBuilder<IconPlaygroundConfig>(
      valueListenable: playgroundState,
      builder: (context, config, _) {
        final catalogIcon = config.selectedIcon;
        final effectiveColor = config.resolveColor(context);
        final hexColorStr = config.colorSource == PlaygroundColorSource.custom
            ? '#${effectiveColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}'
            : '${config.colorSource.label} (#${effectiveColor.toARGB32().toRadixString(16).substring(2).toUpperCase()})';

        final generatedCode = config.generatedFlutterCode(context);

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 1. Header: LIVE PREVIEW & Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LIVE PREVIEW',
                  style: TextStyle(
                    color: mutedText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                ),
                InkWell(
                  onTap: () => playgroundState.reset(),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Row(
                      children: [
                        Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryText,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.restart_alt_rounded,
                            size: 14, color: secondaryText),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Live Preview Stage Canvas Box
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: border),
              ),
              child: CustomPaint(
                painter: GridDotPainter(
                  dotColor: secondaryText.withAlpha(25),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: config.opacity,
                        child: Icon(
                          catalogIcon.iconData,
                          size: config.size,
                          color: effectiveColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: border),
                        ),
                        child: Text(
                          catalogIcon.name,
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. PROPERTIES Section
            Text(
              'PROPERTIES',
              style: TextStyle(
                color: mutedText,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 14),

            // Size Property Row & Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.aspect_ratio_rounded,
                        size: 14, color: secondaryText),
                    const SizedBox(width: 6),
                    Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: inputBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: border),
                  ),
                  child: Text(
                    '${config.size.toInt()} px',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  '12',
                  style: TextStyle(fontSize: 10, color: mutedText),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      activeTrackColor: theme.colorScheme.primary,
                      inactiveTrackColor: border,
                      thumbColor: theme.colorScheme.primary,
                      overlayColor: theme.colorScheme.primary.withAlpha(30),
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 6),
                    ),
                    child: Slider(
                      value: config.size,
                      min: 12.0,
                      max: 128.0,
                      divisions: 116,
                      onChanged: (val) => playgroundState.updateSize(val),
                    ),
                  ),
                ),
                Text(
                  '128',
                  style: TextStyle(fontSize: 10, color: mutedText),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Color Property Header & Active Color Source Label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryText,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: inputBg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: border),
                  ),
                  child: Text(
                    hexColorStr,
                    style: TextStyle(
                      color: secondaryText,
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Semantic Theme Colors Options
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PlaygroundColorSource.themePrimary,
                  PlaygroundColorSource.themeOnPrimary,
                  PlaygroundColorSource.themeSurface,
                  PlaygroundColorSource.themeOnSurface,
                ].map((source) {
                  final isSelected = config.colorSource == source;
                  final sourceColor =
                      source.resolve(context, customColor: config.customColor);
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: InkWell(
                      onTap: () => playgroundState.updateColorSource(source),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primaryContainer
                              : cardBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color:
                                isSelected ? theme.colorScheme.primary : border,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: sourceColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: border, width: 0.5),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              source.label,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected ? primaryText : secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            // Static Presets Sublabel & Color Swatches
            Text(
              'Static Presets',
              style: TextStyle(
                fontSize: 11,
                color: mutedText,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                ...CatalogColors.inspectorPresets.map((color) {
                  final isSelected =
                      config.colorSource == PlaygroundColorSource.custom &&
                          config.customColor.toARGB32() == color.toARGB32();
                  return GestureDetector(
                    onTap: () => playgroundState.updateCustomColor(color),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isSelected ? theme.colorScheme.primary : border,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: color.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                            )
                          : null,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 18),

            // Opacity Property Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Opacity',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryText,
                  ),
                ),
                Text(
                  '${(config.opacity * 100).toInt()}%',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  '0%',
                  style: TextStyle(fontSize: 10, color: mutedText),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      activeTrackColor: theme.colorScheme.primary,
                      inactiveTrackColor: border,
                      thumbColor: theme.colorScheme.primary,
                      overlayColor: theme.colorScheme.primary.withAlpha(30),
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 6),
                    ),
                    child: Slider(
                      value: config.opacity,
                      min: 0.0,
                      max: 1.0,
                      divisions: 100,
                      onChanged: (val) => playgroundState.updateOpacity(val),
                    ),
                  ),
                ),
                Text(
                  '100%',
                  style: TextStyle(fontSize: 10, color: mutedText),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Divider(color: border, height: 1),
            const SizedBox(height: 14),

            // 3. DETAILS Section
            Text(
              'DETAILS',
              style: TextStyle(
                color: mutedText,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 10),
            _buildDetailRow(
              context,
              label: 'Name',
              value: catalogIcon.name,
              copyText: catalogIcon.name,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 6),
            _buildDetailRow(
              context,
              label: 'Icon',
              value: 'MechanixIcons.${catalogIcon.name}',
              copyText: 'MechanixIcons.${catalogIcon.name}',
              isCode: true,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 6),
            _buildDetailRow(
              context,
              label: 'Unicode',
              value: catalogIcon.formattedCodePoint,
              copyText: catalogIcon.formattedCodePoint,
              isCode: true,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 6),
            _buildDetailRow(
              context,
              label: 'Codepoint',
              value: catalogIcon.hexLiteral,
              copyText: catalogIcon.hexLiteral,
              isCode: true,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 20),

            Divider(color: border, height: 1),
            const SizedBox(height: 14),

            // 4. CODE Section & Dynamic Code Generator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CODE',
                  style: TextStyle(
                    color: mutedText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                ),
                IconButton(
                  onPressed: () => _copyToClipboard(
                    context,
                    generatedCode,
                    'Code',
                  ),
                  icon: Icon(Icons.content_copy_rounded,
                      size: 14, color: secondaryText),
                  tooltip: 'Copy Code',
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: border),
              ),
              child: SelectableText(
                generatedCode,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Copy Code Full-Width Button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () => _copyToClipboard(
                  context,
                  generatedCode,
                  'Code',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.copy_rounded, size: 14),
                label: const Text(
                  'Copy code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    required String copyText,
    bool isCode = false,
    required Color primaryText,
    required Color secondaryText,
  }) {
    return InkWell(
      onTap: () => _copyToClipboard(context, copyText, label),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: secondaryText,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: isCode ? 'monospace' : null,
                    color: primaryText,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.content_copy_rounded,
                  size: 12,
                  color: secondaryText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for background grid dots in the Live Preview stage.
class GridDotPainter extends CustomPainter {
  final Color dotColor;

  GridDotPainter({required this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..strokeWidth = 1.2;

    const spacing = 16.0;
    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant GridDotPainter oldDelegate) =>
      oldDelegate.dotColor != dotColor;
}
