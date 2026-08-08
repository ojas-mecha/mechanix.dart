import 'package:flutter/material.dart';
import 'catalog/catalog_theme.dart';
import 'theme_toggle.dart';

import 'catalog/catalog_app.dart';
import 'pages/navigation_second_page.dart';

void main() {
  runApp(const MechanixApp());
}

class MechanixApp extends StatelessWidget {
  const MechanixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeToggle.instance,
      builder: (context, _) {
        final catalogThemeStyle = ThemeToggle.instance.catalogThemeStyle;
        final mechanixVariant = ThemeToggle.instance.mechanixVariant;
        final themeMode = ThemeToggle.instance.themeMode;

        final lightTheme = CatalogTheme.getTheme(
          style: catalogThemeStyle,
          brightness: Brightness.light,
          mechanixVariant: mechanixVariant,
        );
        final darkTheme = CatalogTheme.getTheme(
          style: catalogThemeStyle,
          brightness: Brightness.dark,
          mechanixVariant: mechanixVariant,
        );

        return _MechanixApp(
          darkTheme: darkTheme,
          lightTheme: lightTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}

class _MechanixApp extends StatelessWidget {
  const _MechanixApp({
    required this.lightTheme,
    required this.darkTheme,
    required this.themeMode,
  });

  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routes: {'/navigation-second-route': (context) => NavigationSecondPage()},
      home: const CatalogAppShell(),
    );
  }
}
