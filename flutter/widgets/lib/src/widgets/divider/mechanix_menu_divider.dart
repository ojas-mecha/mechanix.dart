import 'package:flutter/material.dart';

/// A customizable divider for use inside [MechanixMenu].
class MechanixMenuDivider extends StatelessWidget {
  const MechanixMenuDivider({
    super.key,
    this.color,
    this.thickness = 1,
    this.height = 1,
    this.indent = 0,
    this.endIndent = 0,
  });

  /// Divider color (defaults to theme's dividerColor).
  final Color? color;

  /// Divider thickness.
  final double thickness;

  /// Total height of the divider widget.
  final double height;

  /// Empty space before the divider.
  final double indent;

  /// Empty space after the divider.
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 2),
      child: Divider(
        color: color ?? Theme.of(context).dividerColor,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        height: thickness, // keep divider tight
      ),
    );
  }
}
