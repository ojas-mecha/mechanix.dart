import 'package:flutter/material.dart';
import 'mechanix_button_enums.dart';

/// Resolved specifications (height, icon size, font size, padding, gaps, min tap target)
/// corresponding to a given [MechanixButtonSize].
class MechanixButtonSizeSpec {
  final double height;
  final double iconSize;
  final TextStyle labelTextStyle;
  final EdgeInsets padding;
  final double iconLabelGap;
  final double minTapTargetSize;

  const MechanixButtonSizeSpec({
    required this.height,
    required this.iconSize,
    required this.labelTextStyle,
    required this.padding,
    required this.iconLabelGap,
    required this.minTapTargetSize,
  });

  factory MechanixButtonSizeSpec.of(
    BuildContext context,
    MechanixButtonSize size,
  ) {
    final textTheme = Theme.of(context).textTheme;

    switch (size) {
      case MechanixButtonSize.extraSmall:
        return MechanixButtonSizeSpec(
          height: 28,
          iconSize: 20,
          labelTextStyle: textTheme.labelLarge!,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          iconLabelGap: 4,
          minTapTargetSize: 48,
        );

      case MechanixButtonSize.small:
        return MechanixButtonSizeSpec(
          height: 32,
          iconSize: 20,
          labelTextStyle: textTheme.labelLarge!,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          iconLabelGap: 6,
          minTapTargetSize: 48,
        );

      case MechanixButtonSize.medium:
        return MechanixButtonSizeSpec(
          height: 44,
          iconSize: 24,
          labelTextStyle: textTheme.titleMedium!,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          iconLabelGap: 8,
          minTapTargetSize: 0,
        );

      case MechanixButtonSize.large:
        return MechanixButtonSizeSpec(
          height: 72,
          iconSize: 32,
          labelTextStyle: textTheme.headlineSmall!,
          padding: const EdgeInsets.symmetric(horizontal: 48),
          iconLabelGap: 12,
          minTapTargetSize: 0,
        );

      case MechanixButtonSize.xLarge:
        return MechanixButtonSizeSpec(
          height: 100,
          iconSize: 40,
          labelTextStyle: textTheme.headlineLarge!,
          padding: const EdgeInsets.symmetric(horizontal: 64),
          iconLabelGap: 16,
          minTapTargetSize: 0,
        );
    }
  }
}

/// Extension on [MechanixButtonSize] for convenient access to its specifications.
extension MechanixButtonSizeExtension on MechanixButtonSize {
  MechanixButtonSizeSpec spec(BuildContext context) {
    return MechanixButtonSizeSpec.of(context, this);
  }
}
