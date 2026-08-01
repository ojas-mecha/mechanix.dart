import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
    this.themeMode,
    this.onThemeModeChanged,
  });

  final ThemeMode? themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final mode = themeMode ?? ThemeMode.system;

    return IconButton(
      tooltip: 'Change Theme Mode',
      onPressed: () {
        final nextMode = switch (mode) {
          ThemeMode.dark => ThemeMode.system,
          ThemeMode.light => ThemeMode.dark,
          ThemeMode.system => ThemeMode.light,
        };
        onThemeModeChanged?.call(nextMode);
      },
      icon: switch (mode) {
        ThemeMode.light => const Icon(Icons.light_mode),
        ThemeMode.dark => const Icon(Icons.dark_mode),
        ThemeMode.system => const Icon(Icons.brightness_auto),
      },
    );
  }
}
