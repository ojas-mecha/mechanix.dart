import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';
import 'package:widgets_example/example.dart';
import 'theme_toggle.dart';

import 'pages/navigation_second_page.dart';

void main() {
  di.registerSingleton(ThemeToggle());
  runApp(const MechanixApp());
}

class MechanixApp extends StatelessWidget with WatchItMixin {
  const MechanixApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = watchPropertyValue((ThemeToggle t) => t.themeMode);
    final mechanixVariant =
        watchPropertyValue((ThemeToggle t) => t.mechanixVariant);

    return MechanixTheme(
      data: MechanixThemeData(
        mechanixVariant: mechanixVariant,
      ),
      builder: (context, mechanix, child) => _MechanixApp(
        darkTheme: mechanix.darkTheme,
        lightTheme: mechanix.lightTheme,
        themeMode: themeMode,
      ),
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
      home: Scaffold(
        body: const Example(),
      ),
    );
  }
}
