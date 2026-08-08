import 'package:flutter/material.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

/// Enum representing the available theme styles for the catalog.
enum CatalogThemeStyle {
  monochrome,
  indigo,
}

/// Design-System Theme tokens for the catalog.
@immutable
class CatalogThemeTokens extends ThemeExtension<CatalogThemeTokens> {
  final Color background;
  final Color panelBackground;
  final Color cardBackground;
  final Color inputBackground;
  final Color hoverBackground;
  final Color border;
  final Color borderSubtle;
  final Color primary;
  final Color primaryHover;
  final Color primaryContainer;
  final Color onPrimary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  const CatalogThemeTokens({
    required this.background,
    required this.panelBackground,
    required this.cardBackground,
    required this.inputBackground,
    required this.hoverBackground,
    required this.border,
    required this.borderSubtle,
    required this.primary,
    required this.primaryHover,
    required this.primaryContainer,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
  });

  // 1. Monochrome Dark Palette
  static const monochromeDark = CatalogThemeTokens(
    background: Color(0xFF000000),
    panelBackground: Color(0xFF0A0A0A),
    cardBackground: Color(0xFF141414),
    inputBackground: Color(0xFF111111),
    hoverBackground: Color(0xFF222222),
    border: Color(0xFF262626),
    borderSubtle: Color(0xFF1A1A1A),
    primary: Color(0xFFFFFFFF),
    primaryHover: Color(0xFFE5E5E5),
    primaryContainer: Color(0x33FFFFFF),
    onPrimary: Color(0xFF000000),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFA1A1AA),
    textMuted: Color(0xFF71717A),
  );

  // 2. Monochrome Light Palette
  static const monochromeLight = CatalogThemeTokens(
    background: Color(0xFFFFFFFF),
    panelBackground: Color(0xFFFAFAFA),
    cardBackground: Color(0xFFF4F4F5),
    inputBackground: Color(0xFFFFFFFF),
    hoverBackground: Color(0xFFE4E4E7),
    border: Color(0xFFE4E4E7),
    borderSubtle: Color(0xFFF4F4F5),
    primary: Color(0xFF000000),
    primaryHover: Color(0xFF27272A),
    primaryContainer: Color(0x1A000000),
    onPrimary: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF52525B),
    textMuted: Color(0xFFA1A1AA),
  );

  // 3. Indigo Dark Palette
  static const indigoDark = CatalogThemeTokens(
    background: Color(0xFF0B0E14),
    panelBackground: Color(0xFF0F131C),
    cardBackground: Color(0xFF151924),
    inputBackground: Color(0xFF121620),
    hoverBackground: Color(0xFF1C2230),
    border: Color(0xFF222838),
    borderSubtle: Color(0xFF1A1F2C),
    primary: Color(0xFF6366F1),
    primaryHover: Color(0xFF4F46E5),
    primaryContainer: Color(0x266366F1),
    onPrimary: Color(0xFFFFFFFF),
    textPrimary: Color(0xFFF3F4F6),
    textSecondary: Color(0xFF9CA3AF),
    textMuted: Color(0xFF6B7280),
  );

  // 4. Indigo Light Palette
  static const indigoLight = CatalogThemeTokens(
    background: Color(0xFFF8FAFC),
    panelBackground: Color(0xFFFFFFFF),
    cardBackground: Color(0xFFF1F5F9),
    inputBackground: Color(0xFFFFFFFF),
    hoverBackground: Color(0xFFE2E8F0),
    border: Color(0xFFE2E8F0),
    borderSubtle: Color(0xFFF1F5F9),
    primary: Color(0xFF6366F1),
    primaryHover: Color(0xFF4F46E5),
    primaryContainer: Color(0x266366F1),
    onPrimary: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF94A3B8),
  );

  @override
  CatalogThemeTokens copyWith({
    Color? background,
    Color? panelBackground,
    Color? cardBackground,
    Color? inputBackground,
    Color? hoverBackground,
    Color? border,
    Color? borderSubtle,
    Color? primary,
    Color? primaryHover,
    Color? primaryContainer,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
  }) {
    return CatalogThemeTokens(
      background: background ?? this.background,
      panelBackground: panelBackground ?? this.panelBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      inputBackground: inputBackground ?? this.inputBackground,
      hoverBackground: hoverBackground ?? this.hoverBackground,
      border: border ?? this.border,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimary: onPrimary ?? this.onPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
    );
  }

  @override
  CatalogThemeTokens lerp(ThemeExtension<CatalogThemeTokens>? other, double t) {
    if (other is! CatalogThemeTokens) return this;
    return CatalogThemeTokens(
      background: Color.lerp(background, other.background, t)!,
      panelBackground: Color.lerp(panelBackground, other.panelBackground, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      hoverBackground: Color.lerp(hoverBackground, other.hoverBackground, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
    );
  }
}

class CatalogColors {
  CatalogColors._();

  // Static Color Presets for Inspector
  static const List<Color> inspectorPresets = [
    Color(0xFFFFFFFF), // Pure White
    Color(0xFFE4E4E7), // Light Gray
    Color(0xFFA1A1AA), // Mid Gray
    Color(0xFF52525B), // Dark Gray
    Color(0xFF27272A), // Charcoal
    Color(0xFF000000), // Pure Black
    Color(0xFF6366F1), // Indigo Primary
    Color(0xFF3B82F6), // Blue
    Color(0xFF14B8A6), // Teal
    Color(0xFF10B981), // Emerald Green
    Color(0xFFF59E0B), // Amber / Orange
    Color(0xFFEF4444), // Red
  ];

  static CatalogThemeTokens of(BuildContext context) {
    return Theme.of(context).extension<CatalogThemeTokens>() ??
        CatalogThemeTokens.monochromeDark;
  }
}

class CatalogTheme {
  static ThemeData getTheme({
    required CatalogThemeStyle style,
    required Brightness brightness,
    MechanixVariant? mechanixVariant,
  }) {
    return switch ((style, brightness)) {
      (CatalogThemeStyle.monochrome, Brightness.light) => _buildTheme(
          brightness: Brightness.light,
          tokens: CatalogThemeTokens.monochromeLight,
          mechanixVariant: mechanixVariant,
        ),
      (CatalogThemeStyle.monochrome, Brightness.dark) => _buildTheme(
          brightness: Brightness.dark,
          tokens: CatalogThemeTokens.monochromeDark,
          mechanixVariant: mechanixVariant,
        ),
      (CatalogThemeStyle.indigo, Brightness.light) => _buildTheme(
          brightness: Brightness.light,
          tokens: CatalogThemeTokens.indigoLight,
          mechanixVariant: mechanixVariant,
        ),
      (CatalogThemeStyle.indigo, Brightness.dark) => _buildTheme(
          brightness: Brightness.dark,
          tokens: CatalogThemeTokens.indigoDark,
          mechanixVariant: mechanixVariant,
        ),
    };
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required CatalogThemeTokens tokens,
    MechanixVariant? mechanixVariant,
  }) {
    final isDark = brightness == Brightness.dark;
    final primaryColor = mechanixVariant?.color ?? tokens.primary;
    final colorScheme = isDark
        ? ColorScheme.dark(
            surface: tokens.panelBackground,
            surfaceContainerHighest: tokens.cardBackground,
            primary: primaryColor,
            onPrimary: tokens.onPrimary,
            primaryContainer: mechanixVariant != null
                ? mechanixVariant.color.withAlpha(50)
                : tokens.primaryContainer,
            onSurface: tokens.textPrimary,
            onSurfaceVariant: tokens.textSecondary,
            outline: tokens.border,
            outlineVariant: tokens.borderSubtle,
          )
        : ColorScheme.light(
            surface: tokens.panelBackground,
            surfaceContainerHighest: tokens.cardBackground,
            primary: primaryColor,
            onPrimary: tokens.onPrimary,
            primaryContainer: mechanixVariant != null
                ? mechanixVariant.color.withAlpha(30)
                : tokens.primaryContainer,
            onSurface: tokens.textPrimary,
            onSurfaceVariant: tokens.textSecondary,
            outline: tokens.border,
            outlineVariant: tokens.borderSubtle,
          );

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: tokens.background,
      colorScheme: colorScheme,
      dividerColor: tokens.border,
      fontFamily: 'Overused Grotesk',
      useMaterial3: true,
      extensions: [tokens],
    );
  }

  static ThemeData darkTheme({
    CatalogThemeStyle style = CatalogThemeStyle.monochrome,
    MechanixVariant? mechanixVariant,
  }) {
    return getTheme(
      style: style,
      brightness: Brightness.dark,
      mechanixVariant: mechanixVariant,
    );
  }

  static ThemeData lightTheme({
    CatalogThemeStyle style = CatalogThemeStyle.monochrome,
    MechanixVariant? mechanixVariant,
  }) {
    return getTheme(
      style: style,
      brightness: Brightness.light,
      mechanixVariant: mechanixVariant,
    );
  }
}
