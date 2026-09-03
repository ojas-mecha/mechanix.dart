import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
export 'mechanix_button_enums.dart';
export 'mechanix_button_size.dart';

/// A highly customizable button component following the
/// Mechanix design system specifications, wrapping Flutter Material's
/// [FilledButton] and [OutlinedButton].
class MechanixButton extends StatelessWidget {
  const MechanixButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = MechanixButtonType.square,
    this.variant = MechanixButtonVariant.filled,
    this.size = MechanixButtonSize.medium,
    this.widthSizing = MechanixButtonSizing.hug,
    this.heightSizing = MechanixButtonSizing.hug,
    this.width,
    this.height,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.theme,
  });

  /// Factory constructor for a Filled [MechanixButton].
  const MechanixButton.filled({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = MechanixButtonType.square,
    this.size = MechanixButtonSize.medium,
    this.widthSizing = MechanixButtonSizing.hug,
    this.heightSizing = MechanixButtonSizing.hug,
    this.width,
    this.height,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.theme,
  }) : variant = MechanixButtonVariant.filled;

  /// Factory constructor for an Outline [MechanixButton].
  const MechanixButton.outline({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = MechanixButtonType.square,
    this.size = MechanixButtonSize.medium,
    this.widthSizing = MechanixButtonSizing.hug,
    this.heightSizing = MechanixButtonSizing.hug,
    this.width,
    this.height,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.theme,
  }) : variant = MechanixButtonVariant.outline;

  /// Alias constructor for an Outline [MechanixButton].
  const MechanixButton.outlined({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = MechanixButtonType.square,
    this.size = MechanixButtonSize.medium,
    this.widthSizing = MechanixButtonSizing.hug,
    this.heightSizing = MechanixButtonSizing.hug,
    this.width,
    this.height,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.theme,
  }) : variant = MechanixButtonVariant.outline;

  /// Callback when button is clicked. If null, button is disabled.
  final VoidCallback? onPressed;

  /// Callback when button is long pressed.
  final VoidCallback? onLongPress;

  /// String label text.
  final String? label;

  /// Custom Widget label text (overrides [label] string if provided).
  final Widget? labelText;

  /// Icon widget or IconData to display.
  final dynamic icon;

  /// Controls whether the icon should be displayed. Defaults to true.
  final bool showIcon;

  /// Corner/shape style type ([MechanixButtonType.square], [rounded]).
  final MechanixButtonType type;

  /// Visual style variant ([MechanixButtonVariant.filled], [outline]).
  final MechanixButtonVariant variant;

  /// Button scale size ([MechanixButtonSize.xSmall], [small], [medium], [large], [xLarge]).
  final MechanixButtonSize size;

  /// Width sizing strategy (hug, fill, fixed).
  final MechanixButtonSizing widthSizing;

  /// Height sizing strategy (hug, fill, fixed).
  final MechanixButtonSizing heightSizing;

  /// Explicit width when [widthSizing] is fixed.
  final double? width;

  /// Explicit height when [heightSizing] is fixed.
  final double? height;

  /// Controls whether focus border indicator outline is shown when focused.
  final bool showFocusIndicator;

  /// Optional FocusNode.
  final FocusNode? focusNode;

  /// Whether this button should auto focus on init.
  final bool autofocus;

  /// Hover/press/focus animation duration.
  final Duration duration;

  /// Hover/press/focus animation easing curve.
  final Curve curve;

  /// Background color overrides.
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? disabledColor;

  /// Foreground / Text / Icon color overrides.
  final Color? foregroundColor;
  final Color? hoverForegroundColor;
  final Color? pressedForegroundColor;
  final Color? disabledForegroundColor;

  /// Border styling overrides.
  final Color? borderColor;
  final double? borderWidth;
  final Color? focusBorderColor;

  /// Custom theme override for this button instance.
  final MechanixButtonThemeData? theme;

  bool get isEnabled => onPressed != null || onLongPress != null;

  (double?, double?) _resolveDimensions(double defaultHeight) {
    double? resolvedWidth;
    if (widthSizing == MechanixButtonSizing.fill) {
      resolvedWidth = double.infinity;
    } else if (widthSizing == MechanixButtonSizing.fixed) {
      resolvedWidth = width;
    }

    double? resolvedHeight;
    if (heightSizing == MechanixButtonSizing.fill) {
      resolvedHeight = double.infinity;
    } else if (heightSizing == MechanixButtonSizing.fixed) {
      resolvedHeight = height;
    } else {
      resolvedHeight = height ?? defaultHeight;
    }

    return (resolvedWidth, resolvedHeight);
  }

  @override
  Widget build(BuildContext context) {
    final mergedTheme = MechanixButtonTheme.of(context).merge(theme);
    final sizeSpec = size.spec(context);

    final buttonStyle = MechanixButtonStyle.createButtonStyle(
      context: context,
      variant: variant,
      type: type,
      sizeSpec: sizeSpec,
      theme: mergedTheme,
      customBackgroundColor: backgroundColor,
      customHoverColor: hoverColor,
      customPressedColor: pressedColor,
      customDisabledColor: disabledColor,
      customForegroundColor: foregroundColor,
      customHoverForegroundColor: hoverForegroundColor,
      customPressedForegroundColor: pressedForegroundColor,
      customDisabledForegroundColor: disabledForegroundColor,
      customBorderColor: borderColor,
      customBorderWidth: borderWidth,
      customFocusBorderColor: focusBorderColor,
      duration: duration,
      curve: curve,
      showFocusIndicator: showFocusIndicator,
    );

    final buttonChild = Builder(
      builder: (context) => _buildContent(context, mergedTheme, sizeSpec),
    );

    Widget buttonWidget;
    switch (variant) {
      case MechanixButtonVariant.filled:
        buttonWidget = FilledButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
      case MechanixButtonVariant.outline:
        buttonWidget = OutlinedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
    }

    final (resolvedWidth, resolvedHeight) = _resolveDimensions(sizeSpec.height);

    Widget resultWidget = buttonWidget;

    if (resolvedWidth != null || resolvedHeight != null) {
      resultWidget = SizedBox(
        width: resolvedWidth,
        height: resolvedHeight,
        child: resultWidget,
      );
    }

    if (sizeSpec.minTapTargetSize > 0) {
      resultWidget = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        onLongPress: onLongPress,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: sizeSpec.minTapTargetSize,
            minHeight: sizeSpec.minTapTargetSize,
          ),
          child: Center(
            widthFactor: widthSizing == MechanixButtonSizing.hug ? 1.0 : null,
            heightFactor: heightSizing == MechanixButtonSizing.hug ? 1.0 : null,
            child: resultWidget,
          ),
        ),
      );
    } else if (widthSizing == MechanixButtonSizing.hug ||
        heightSizing == MechanixButtonSizing.hug) {
      resultWidget = Center(
        widthFactor: widthSizing == MechanixButtonSizing.hug ? 1.0 : null,
        heightFactor: heightSizing == MechanixButtonSizing.hug ? 1.0 : null,
        child: resultWidget,
      );
    }

    return resultWidget;
  }

  Widget _buildContent(
    BuildContext context,
    MechanixButtonThemeData theme,
    MechanixButtonSizeSpec sizeSpec,
  ) {
    final iconWidget = _buildIcon(theme, sizeSpec);
    final textWidget = _buildText(context, theme, sizeSpec);

    final children = <Widget>[];

    if (iconWidget != null) {
      children.add(iconWidget);
    }

    if (iconWidget != null && textWidget != null) {
      children.add(SizedBox(width: sizeSpec.iconLabelGap));
    }

    if (textWidget != null) {
      children.add(textWidget);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget? _buildIcon(
    MechanixButtonThemeData theme,
    MechanixButtonSizeSpec sizeSpec,
  ) {
    if (!showIcon || icon == null) return null;

    if (icon is Widget) {
      return icon as Widget;
    } else if (icon is IconData) {
      return Icon(icon as IconData, size: theme.iconSize ?? sizeSpec.iconSize);
    }
    return null;
  }

  Widget? _buildText(
    BuildContext context,
    MechanixButtonThemeData theme,
    MechanixButtonSizeSpec sizeSpec,
  ) {
    if (labelText != null) {
      return labelText;
    }
    if (label != null) {
      final baseStyle = theme.textStyle ?? sizeSpec.labelTextStyle;
      final defaultColor = DefaultTextStyle.of(context).style.color;
      return Text(
        label!,
        style: baseStyle.copyWith(color: defaultColor),
      );
    }
    return null;
  }
}
