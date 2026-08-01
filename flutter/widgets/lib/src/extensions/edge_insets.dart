import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

extension Spacing on EdgeInsets {
  static const xs = EdgeInsets.all(mechanixPaddingXs);

  static const sm = EdgeInsets.all(mechanixPaddingSm);

  static const md = EdgeInsets.all(mechanixPaddingMd);

  static const lg = EdgeInsets.all(mechanixPaddingLg);

  static const xl = EdgeInsets.all(mechanixPaddingXl);

  static EdgeInsets all([double value = mechanixMargin]) =>
      EdgeInsets.all(value);

  static EdgeInsets horizontal([double value = mechanixMargin]) =>
      EdgeInsets.symmetric(horizontal: value);

  static EdgeInsets vertical([double value = mechanixMargin]) =>
      EdgeInsets.symmetric(vertical: value);

  static EdgeInsets symmetric({double h = 0, double v = 0}) =>
      EdgeInsets.symmetric(horizontal: h, vertical: v);

  static EdgeInsets only({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      );

  static EdgeInsets left([double value = mechanixMargin]) =>
      EdgeInsets.only(left: value);

  static EdgeInsets right([double value = mechanixMargin]) =>
      EdgeInsets.only(right: value);

  static EdgeInsets top([double value = mechanixMargin]) =>
      EdgeInsets.only(top: value);

  static EdgeInsets bottom([double value = mechanixMargin]) =>
      EdgeInsets.only(bottom: value);
}

extension WidgetPadding on Widget {
  static const padXs = EdgeInsets.all(mechanixPaddingXs);

  static const padSm = EdgeInsets.all(mechanixPaddingSm);

  static const padMd = EdgeInsets.all(mechanixPaddingMd);

  static const padLg = EdgeInsets.all(mechanixPaddingLg);

  static const padXl = EdgeInsets.all(mechanixPaddingXl);

  static const padRightMd = EdgeInsets.all(mechanixPaddingMd);

  Widget padAll([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget padHorizontal([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget padVertical([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  Widget padSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget padOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget padLeft([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  Widget padRight([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  Widget padTop([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  Widget padBottom([double value = mechanixPaddingMd]) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }
}
