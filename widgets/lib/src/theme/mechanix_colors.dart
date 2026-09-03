import 'package:flutter/material.dart';

/// Mechanix color specifications, tonal palettes, and color schemes.
abstract final class MechanixColors {
  /// The official Mechanix light [ColorScheme].
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF7230),
    onPrimary: Color(0xFF050505),
    primaryContainer: Color(0xFFE15B0E),
    onPrimaryContainer: Color(0xFFF4F4F5),
    primaryFixed: Color(0xFFE15B0E),
    primaryFixedDim: Color(0xFFE06924),
    onPrimaryFixed: Color(0xFF414144),
    onPrimaryFixedVariant: Color(0xFFDBDBDC),
    secondary: Color(0xFFF4F4F5),
    onSecondary: Color(0xFFFF7230),
    secondaryContainer: Color(0xFFDBDBDC),
    onSecondaryContainer: Color(0xFF75757A),
    secondaryFixed: Color(0xFFDBDBDC),
    secondaryFixedDim: Color(0xFFC0C0C3),
    onSecondaryFixed: Color(0xFF49494B),
    onSecondaryFixedVariant: Color(0xFF49494B),
    error: Color(0xFFFF4242),
    onError: Color(0xFFF4F4F5),
    errorContainer: Color(0xFFA80404),
    onErrorContainer: Color(0xFFFFEBEB),
    surface: Color(0xFFDBDBDC),
    onSurface: Color(0xFF414144),
    surfaceDim: Color(0xFFFFFFFF),
    surfaceBright: Color(0xFFFFFFFF),
    surfaceContainerLowest: Color(0xFFF4F4F5),
    surfaceContainerLow: Color(0xFFEDEDEE),
    surfaceContainer: Color(0xFFEDEDEE),
    surfaceContainerHigh: Color(0xFFF4F4F5),
    surfaceContainerHighest: Color(0xFFFFFFFF),
    onSurfaceVariant: Color(0xFFA5A5A7),
    outline: Color(0xFFC8C8CB),
    outlineVariant: Color(0xFFF4F4F5),
    inverseSurface: Color(0xFF050505),
    onInverseSurface: Color(0xFFEDEDEE),
    inversePrimary: Color(0xFF242424),
    scrim: Color(0xFFA5A5A7),
    shadow: Color(0xFFA5A5A7),
  );

  /// The official Mechanix dark [ColorScheme].
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF9640D),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFCA67B),
    onPrimaryContainer: Color(0xFF141415),
    primaryFixed: Color(0xFFFC8845),
    primaryFixedDim: Color(0xFFFC8845),
    onPrimaryFixed: Color(0xFFE0E0E1),
    onPrimaryFixedVariant: Color(0xFF232325),
    secondary: Color(0xFF141415),
    onSecondary: Color(0xFFFF7230),
    secondaryContainer: Color(0xFF232325),
    onSecondaryContainer: Color(0xFFA1A1A5),
    secondaryFixed: Color(0xFF373739),
    secondaryFixedDim: Color(0xFF3E3E40),
    onSecondaryFixed: Color(0xFF8D8D91),
    onSecondaryFixedVariant: Color(0xFFA1A1A5),
    error: Color(0xFFFF4242),
    onError: Color(0xFFF5F5F5),
    errorContainer: Color(0xFFA80404),
    onErrorContainer: Color(0xFFFEE9E9),
    surface: Color(0xFF1A1A1B),
    onSurface: Color(0xFFF5F5F5),
    surfaceDim: Color(0xFF050505),
    surfaceBright: Color(0xFF232325),
    surfaceContainerLowest: Color(0xFF050505),
    surfaceContainerLow: Color(0xFF141415),
    surfaceContainer: Color(0xFF19191A),
    surfaceContainerHigh: Color(0xFF232325),
    surfaceContainerHighest: Color(0xFF373739),
    onSurfaceVariant: Color(0xFF646468),
    outline: Color(0xFF373739),
    outlineVariant: Color(0xFF141415),
    inverseSurface: Color(0xFFFFFFFF),
    onInverseSurface: Color(0xFF232325),
    inversePrimary: Color(0xFFFC8845),
    scrim: Color(0xFF050505),
    shadow: Color(0xFF050505),
  );

  /// The default brand orange accent color.
  static const Color defaultAccentColor = Color(0xFFFF7230);

  /// Generates a light [ColorScheme] for Mechanix apps with the specified [accentColor].
  static ColorScheme createLightColorScheme({Color? accentColor}) {
    if (accentColor == null) {
      return lightColorScheme;
    }
    final seed = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: Brightness.light,
    );
    return lightColorScheme.copyWith(
      primary: accentColor,
      onPrimary: seed.onPrimary,
      primaryContainer: seed.primaryContainer,
      onPrimaryContainer: seed.onPrimaryContainer,
      primaryFixed: seed.primaryFixed,
      primaryFixedDim: seed.primaryFixedDim,
      onPrimaryFixed: seed.onPrimaryFixed,
      onPrimaryFixedVariant: seed.onPrimaryFixedVariant,
      onSecondary: accentColor,
      inversePrimary: seed.inversePrimary,
    );
  }

  /// Generates a dark [ColorScheme] for Mechanix apps with the specified [accentColor].
  static ColorScheme createDarkColorScheme({Color? accentColor}) {
    if (accentColor == null) {
      return darkColorScheme;
    }
    final seed = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: Brightness.dark,
    );
    return darkColorScheme.copyWith(
      primary: accentColor,
      onPrimary: seed.onPrimary,
      primaryContainer: seed.primaryContainer,
      onPrimaryContainer: seed.onPrimaryContainer,
      primaryFixed: seed.primaryFixed,
      primaryFixedDim: seed.primaryFixedDim,
      onPrimaryFixed: seed.onPrimaryFixed,
      onPrimaryFixedVariant: seed.onPrimaryFixedVariant,
      onSecondary: accentColor,
      inversePrimary: seed.inversePrimary,
    );
  }
}
