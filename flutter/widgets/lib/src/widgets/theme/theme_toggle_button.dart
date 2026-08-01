import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:widgets/widgets/theme/theme_toggle.dart';

class ThemeToggleButton extends StatelessWidget with WatchItMixin {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = watchPropertyValue((ThemeToggle t) => t.themeMode);

    return IconButton(
      tooltip: 'Change Theme Mode',
      onPressed: () => di<ThemeToggle>().setThemeMode(switch (themeMode) {
        ThemeMode.dark => ThemeMode.system,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.system => ThemeMode.light,
      }),
      icon: switch (themeMode) {
        ThemeMode.light => const Icon(Icons.light_mode),
        ThemeMode.dark => const Icon(Icons.dark_mode),
        ThemeMode.system => const Icon(Icons.brightness_auto),
      },
    );
  }
}
