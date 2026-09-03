import 'package:flutter/material.dart';

import 'inherited_theme.dart';
import 'mechanix_colors.dart';
import 'mechanix_theme_data.dart';
import 'mechanix_typography.dart';

export 'inherited_theme.dart';
export 'mechanix_theme_data.dart';

/// The Mechanix theme definitions and reactive theme widget factory.
///
/// Use [MechanixTheme] either as a static [ThemeData] provider:
/// ```dart
/// MaterialApp(
///   theme: MechanixTheme.light,
///   darkTheme: MechanixTheme.dark,
///   themeMode: ThemeMode.system,
/// );
/// ```
///
/// Or as a reactive theme scope wrapping your app:
/// ```dart
/// MechanixTheme(
///   accentColor: Colors.blue,
///   themeMode: ThemeMode.system,
///   builder: (context, theme, child) {
///     return MaterialApp(
///       theme: theme.light,
///       darkTheme: theme.dark,
///       themeMode: theme.mode,
///       home: child,
///     );
///   },
///   child: const MyHomePage(),
/// );
/// ```
abstract class MechanixTheme extends StatefulWidget {
  /// Creates a reactive [MechanixTheme] widget.
  const factory MechanixTheme({
    Key? key,
    Color? accentColor,
    ThemeMode themeMode,
    ValueWidgetBuilder<MechanixThemeData>? builder,
    Widget? child,
  }) = MechanixThemeScope;

  // ---------------------------------------------------------------------------
  // Static theme & color getters for direct usage (backwards compatibility)
  // ---------------------------------------------------------------------------

  /// The default light [ThemeData] for Mechanix applications.
  static ThemeData get light =>
      createTheme(colorScheme: MechanixColors.lightColorScheme);

  /// The default dark [ThemeData] for Mechanix applications.
  static ThemeData get dark =>
      createTheme(colorScheme: MechanixColors.darkColorScheme);

  /// The official light [ColorScheme] for Mechanix applications.
  static ColorScheme get lightColorScheme => MechanixColors.lightColorScheme;

  /// The official dark [ColorScheme] for Mechanix applications.
  static ColorScheme get darkColorScheme => MechanixColors.darkColorScheme;

  /// Creates a [ThemeData] configured with Mechanix specifications for the given [colorScheme].
  static ThemeData createTheme({required ColorScheme colorScheme}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: createTextTheme(textColor: colorScheme.onSurface),
    );
  }

  /// Obtains the nearest [MechanixThemeData] from the given [context].
  static MechanixThemeData of(BuildContext context) {
    return MechanixThemeScope.of(context);
  }

  /// Obtains the nearest [MechanixThemeData] from the given [context], or null if none exists.
  static MechanixThemeData? maybeOf(BuildContext context) {
    return MechanixThemeScope.maybeOf(context);
  }

  /// Updates the theme mode for the nearest enclosing theme scope.
  static void setThemeMode(BuildContext context, ThemeMode mode) {
    MechanixThemeScope.setThemeMode(context, mode);
  }

  /// Updates the accent color for the nearest enclosing theme scope.
  static void setAccentColor(BuildContext context, Color? color) {
    MechanixThemeScope.setAccentColor(context, color);
  }
}
