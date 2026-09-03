import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Helper for constructing Material [ButtonStyle] configurations for [MechanixButton].
abstract class MechanixButtonStyle {
  const MechanixButtonStyle();

  /// Creates a Material [ButtonStyle] for [MechanixButton] using variant,
  /// type, sizing spec, theme data, and custom color overrides.
  static ButtonStyle createButtonStyle({
    required BuildContext context,
    required MechanixButtonVariant variant,
    required MechanixButtonType type,
    required MechanixButtonSizeSpec sizeSpec,
    MechanixButtonThemeData? theme,
    Color? customBackgroundColor,
    Color? customHoverColor,
    Color? customPressedColor,
    Color? customDisabledColor,
    Color? customForegroundColor,
    Color? customHoverForegroundColor,
    Color? customPressedForegroundColor,
    Color? customDisabledForegroundColor,
    Color? customBorderColor,
    double? customBorderWidth,
    Color? customFocusBorderColor,
    Duration? duration,
    Curve? curve,
    bool showFocusIndicator = true,
  }) {
    final scheme = context.colorScheme;
    final isOutline = variant == MechanixButtonVariant.outline;

    final borderRadius = switch (type) {
      MechanixButtonType.square =>
        theme?.borderRadius ?? BorderRadius.circular(0),
      MechanixButtonType.rounded =>
        theme?.borderRadius ?? BorderRadius.circular(sizeSpec.height / 2),
    };

    final shape = RoundedRectangleBorder(borderRadius: borderRadius);

    final baseBg = customBackgroundColor ?? theme?.backgroundColor;
    final baseFg = customForegroundColor ?? theme?.foregroundColor;
    final baseBorderColor = customBorderColor ?? theme?.borderColor;
    final baseBorderWidth = customBorderWidth ?? theme?.borderWidth;

    final backgroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        if (customDisabledColor != null || theme?.disabledColor != null) {
          return customDisabledColor ?? theme?.disabledColor;
        }
        return isOutline
            ? Colors.transparent
            : scheme.onSurface.withValues(alpha: 0.10);
      }
      if (states.contains(WidgetState.pressed)) {
        if (customPressedColor != null || theme?.pressedColor != null) {
          return customPressedColor ?? theme?.pressedColor;
        }
        final bg =
            baseBg ??
            (isOutline ? Colors.transparent : scheme.secondaryFixedDim);
        final layerColor = isOutline ? scheme.primary : scheme.onPrimary;
        return _applyStateLayer(
          baseColor: bg,
          stateLayerColor: layerColor,
          opacity: 0.12,
        );
      }
      if (states.contains(WidgetState.hovered)) {
        if (customHoverColor != null || theme?.hoverColor != null) {
          return customHoverColor ?? theme?.hoverColor;
        }
        final bg =
            baseBg ??
            (isOutline ? Colors.transparent : scheme.secondaryFixedDim);
        final layerColor = isOutline ? scheme.primary : scheme.onPrimary;
        return _applyStateLayer(
          baseColor: bg,
          stateLayerColor: layerColor,
          opacity: 0.08,
        );
      }
      if (states.contains(WidgetState.focused)) {
        final bg =
            baseBg ??
            (isOutline ? Colors.transparent : scheme.secondaryFixedDim);
        final layerColor = isOutline ? scheme.primary : scheme.outline;
        return _applyStateLayer(
          baseColor: bg,
          stateLayerColor: layerColor,
          opacity: 0.12,
        );
      }
      return baseBg;
    });

    final foregroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        if (customDisabledForegroundColor != null ||
            theme?.disabledForegroundColor != null) {
          return customDisabledForegroundColor ??
              theme?.disabledForegroundColor;
        }
        return isOutline
            ? scheme.onSurface.withValues(alpha: 0.38)
            : scheme.onSurface.withValues(alpha: 0.10);
      }
      if (states.contains(WidgetState.pressed)) {
        if (customPressedForegroundColor != null ||
            theme?.pressedForegroundColor != null) {
          return customPressedForegroundColor ?? theme?.pressedForegroundColor;
        }
      }
      if (states.contains(WidgetState.hovered)) {
        if (customHoverForegroundColor != null ||
            theme?.hoverForegroundColor != null) {
          return customHoverForegroundColor ?? theme?.hoverForegroundColor;
        }
      }
      return baseFg;
    });

    final sideProperty = WidgetStateProperty.resolveWith<BorderSide?>((states) {
      if (isOutline) {
        final w = baseBorderWidth ?? 1.0;
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: baseBorderColor ?? scheme.onSurface.withValues(alpha: 0.10),
            width: w,
          );
        }
        if (states.contains(WidgetState.focused) && showFocusIndicator) {
          final focColor =
              customFocusBorderColor ??
              theme?.focusBorderColor ??
              baseBorderColor ??
              scheme.outline;
          final focWidth = customBorderWidth ?? theme?.borderWidth ?? 3.0;
          return BorderSide(color: focColor, width: focWidth);
        }
        return BorderSide(color: baseBorderColor ?? scheme.outline, width: w);
      } else {
        if (baseBorderColor != null) {
          final w = baseBorderWidth ?? 0.0;
          if (states.contains(WidgetState.focused) &&
              showFocusIndicator &&
              (customFocusBorderColor != null ||
                  theme?.focusBorderColor != null)) {
            final focColor = customFocusBorderColor ?? theme?.focusBorderColor!;
            return BorderSide(color: focColor!, width: w);
          }
          return BorderSide(color: baseBorderColor, width: w);
        }
        return null;
      }
    });

    return ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: backgroundColorProperty,
      foregroundColor: foregroundColorProperty,
      iconColor: foregroundColorProperty,
      side: sideProperty,
      shape: WidgetStateProperty.all(shape),
      padding: WidgetStateProperty.all(theme?.padding ?? sizeSpec.padding),
      minimumSize: WidgetStateProperty.all(
        Size(sizeSpec.minTapTargetSize, sizeSpec.minTapTargetSize),
      ),
      textStyle: WidgetStateProperty.all(
        theme?.textStyle ?? sizeSpec.labelTextStyle,
      ),
      iconSize: WidgetStateProperty.all(theme?.iconSize ?? sizeSpec.iconSize),
      animationDuration: duration ?? const Duration(milliseconds: 200),
    );
  }
}

Color _applyStateLayer({
  required Color baseColor,
  required Color stateLayerColor,
  required double opacity,
}) {
  return Color.alphaBlend(
    stateLayerColor.withValues(alpha: opacity),
    baseColor,
  );
}
