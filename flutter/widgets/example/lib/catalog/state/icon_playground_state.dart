import 'package:flutter/material.dart';

import '../catalog_icon_data.dart';

const double kDefaultIconSize = 32.0;
const Color kDefaultIconColor = Color(0xFFFFFFFF);
const double kDefaultIconOpacity = 1.0;

enum PlaygroundColorSource {
  custom,
  themePrimary,
  themeOnPrimary,
  themeSurface,
  themeOnSurface,
}

extension PlaygroundColorSourceExtension on PlaygroundColorSource {
  String get label {
    return switch (this) {
      PlaygroundColorSource.custom => 'Custom',
      PlaygroundColorSource.themePrimary => 'Theme Primary',
      PlaygroundColorSource.themeOnPrimary => 'Theme On Primary',
      PlaygroundColorSource.themeSurface => 'Theme Surface',
      PlaygroundColorSource.themeOnSurface => 'Theme On Surface',
    };
  }

  String get codeSnippet {
    return switch (this) {
      PlaygroundColorSource.custom => '',
      PlaygroundColorSource.themePrimary =>
        'Theme.of(context).colorScheme.primary',
      PlaygroundColorSource.themeOnPrimary =>
        'Theme.of(context).colorScheme.onPrimary',
      PlaygroundColorSource.themeSurface =>
        'Theme.of(context).colorScheme.surface',
      PlaygroundColorSource.themeOnSurface =>
        'Theme.of(context).colorScheme.onSurface',
    };
  }

  Color resolve(BuildContext context, {required Color customColor}) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      PlaygroundColorSource.custom => customColor,
      PlaygroundColorSource.themePrimary => scheme.primary,
      PlaygroundColorSource.themeOnPrimary => scheme.onPrimary,
      PlaygroundColorSource.themeSurface => scheme.surface,
      PlaygroundColorSource.themeOnSurface => scheme.onSurface,
    };
  }
}

class IconPlaygroundConfig {
  final CatalogIcon selectedIcon;
  final double size;
  final PlaygroundColorSource colorSource;
  final Color customColor;
  final double opacity;

  const IconPlaygroundConfig({
    required this.selectedIcon,
    this.size = kDefaultIconSize,
    this.colorSource = PlaygroundColorSource.themePrimary,
    this.customColor = kDefaultIconColor,
    this.opacity = kDefaultIconOpacity,
  });

  /// Resolves the effective rendering color dynamically based on BuildContext.
  Color resolveColor(BuildContext context) {
    return colorSource.resolve(context, customColor: customColor);
  }

  IconPlaygroundConfig copyWith({
    CatalogIcon? selectedIcon,
    double? size,
    PlaygroundColorSource? colorSource,
    Color? customColor,
    double? opacity,
  }) {
    return IconPlaygroundConfig(
      selectedIcon: selectedIcon ?? this.selectedIcon,
      size: size ?? this.size,
      colorSource: colorSource ?? this.colorSource,
      customColor: customColor ?? this.customColor,
      opacity: opacity ?? this.opacity,
    );
  }

  /// Generates clean, production-ready Flutter code for the current icon setup.
  String generatedFlutterCode(BuildContext context) {
    final buffer = StringBuffer();
    final bool hasSize = size != 24.0; // 24 is Flutter's default Icon size
    final bool hasOpacity = opacity < 1.0;

    String colorExpr = '';
    if (colorSource == PlaygroundColorSource.custom) {
      final hexStr = customColor
          .toARGB32()
          .toRadixString(16)
          .toUpperCase()
          .padLeft(8, '0');
      colorExpr = 'const Color(0x$hexStr)';
    } else {
      colorExpr = colorSource.codeSnippet;
    }

    if (hasOpacity) {
      buffer.writeln('Opacity(');
      buffer.writeln('  opacity: ${opacity.toStringAsFixed(2)},');
      buffer.writeln('  child: Icon(');
      buffer.writeln('    MechanixIcons.${selectedIcon.name},');
      if (hasSize) {
        buffer.writeln('    size: ${size.toInt()},');
      }
      if (colorExpr.isNotEmpty) {
        buffer.writeln('    color: $colorExpr,');
      }
      buffer.writeln('  ),');
      buffer.write(')');
    } else {
      buffer.writeln('Icon(');
      buffer.writeln('  MechanixIcons.${selectedIcon.name},');
      if (hasSize) {
        buffer.writeln('  size: ${size.toInt()},');
      }
      if (colorExpr.isNotEmpty) {
        buffer.writeln('  color: $colorExpr,');
      }
      buffer.write(')');
    }

    return buffer.toString();
  }
}

class IconPlaygroundState extends ValueNotifier<IconPlaygroundConfig> {
  IconPlaygroundState({CatalogIcon? initialIcon})
      : super(
          IconPlaygroundConfig(
            selectedIcon: initialIcon ?? catalogIcons.first,
          ),
        );

  void selectIcon(CatalogIcon icon) {
    value = value.copyWith(selectedIcon: icon);
  }

  void updateSize(double size) {
    value = value.copyWith(size: size.clamp(12.0, 128.0));
  }

  /// Set static custom color
  void updateCustomColor(Color color) {
    value = value.copyWith(
      colorSource: PlaygroundColorSource.custom,
      customColor: color,
    );
  }

  /// Set semantic theme color source
  void updateColorSource(PlaygroundColorSource source, {Color? customColor}) {
    value = value.copyWith(
      colorSource: source,
      customColor: customColor,
    );
  }

  void updateOpacity(double opacity) {
    value = value.copyWith(opacity: opacity.clamp(0.0, 1.0));
  }

  /// Resets property controls to defaults while keeping selected icon.
  void reset() {
    value = IconPlaygroundConfig(
      selectedIcon: value.selectedIcon,
      size: kDefaultIconSize,
      colorSource: PlaygroundColorSource.themePrimary,
      customColor: kDefaultIconColor,
      opacity: kDefaultIconOpacity,
    );
  }
}
