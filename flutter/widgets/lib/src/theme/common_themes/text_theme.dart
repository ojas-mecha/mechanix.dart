import 'package:flutter/material.dart';
import '../../constants/package_constants.dart';

TextTheme createTextTheme(
    {required onSurface, required Color onSurfaceVariant}) {
  return TextTheme(
    displayLarge: TextStyle(
      color: onSurface,
      fontSize: 59,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    displayMedium: TextStyle(
      color: onSurface,
      fontSize: 47,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    displaySmall: TextStyle(
      color: onSurface,
      fontSize: 38,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    headlineLarge: TextStyle(
      color: onSurface,
      fontSize: 34,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    headlineMedium: TextStyle(
      color: onSurface,
      fontSize: 30,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    headlineSmall: TextStyle(
      color: onSurface,
      fontSize: 26,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    titleLarge: TextStyle(
      color: onSurface,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    titleMedium: TextStyle(
      color: onSurface,
      fontSize: 20,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    titleSmall: TextStyle(
      color: onSurface,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    bodyLarge: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    bodyMedium: TextStyle(
      color: onSurface,
      fontSize: 20,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    bodySmall: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
    labelLarge: TextStyle(
      color: onSurfaceVariant,
      fontSize: 18,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ), // settings section list menu label
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: onSurface,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ), // settings section list menu label
    labelSmall: TextStyle(
      fontSize: 18,
      color: onSurface,
      fontWeight: FontWeight.w400,
      fontFamily: 'Overused Grotesk',
      package: kPackageName,
    ),
  );
}
