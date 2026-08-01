import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

extension CircularRadius on BorderRadius {
  static final xs = BorderRadius.circular(2.0);

  static final sm = BorderRadius.circular(4.0);

  static final md = BorderRadius.circular(8.0);

  static final lg = BorderRadius.circular(12.0);

  static final xl = BorderRadius.circular(16.0);

  static final circle = BorderRadius.circular(50.0);

  static BorderRadius all([double radius = mechanixRadius]) =>
      BorderRadius.circular(radius);

  static BorderRadius topAll([double radius = mechanixRadius]) =>
      BorderRadius.vertical(
          top: Radius.circular(radius), bottom: Radius.circular(0));

  static BorderRadius bottomAll([double radius = mechanixRadius]) =>
      BorderRadius.vertical(
          top: Radius.circular(0), bottom: Radius.circular(radius));
}

extension HorizontalRadius on BorderRadius {
  static BorderRadius only(
          {double leftX = 0,
          double leftY = 0,
          double rightX = 0,
          double rightY = 0}) =>
      BorderRadius.horizontal(
          left: Radius.elliptical(leftX, leftY),
          right: Radius.elliptical(rightX, rightY));

  static BorderRadius left(
          {double x = mechanixRadius, double y = mechanixRadius}) =>
      BorderRadius.horizontal(
          left: Radius.elliptical(x, y), right: Radius.elliptical(0, 0));

  static BorderRadius leftAll([double left = mechanixRadius]) =>
      BorderRadius.horizontal(
          left: Radius.elliptical(left, left), right: Radius.elliptical(0, 0));

  static BorderRadius right(
          {double x = mechanixRadius, double y = mechanixRadius}) =>
      BorderRadius.horizontal(
          left: Radius.elliptical(0, 0), right: Radius.elliptical(x, y));

  static BorderRadius rightAll([double right = mechanixRadius]) =>
      BorderRadius.horizontal(
          left: Radius.elliptical(0, 0),
          right: Radius.elliptical(right, right));
}

extension VerticalRadius on BorderRadius {
  static BorderRadius onlyElliptical(
          {double topX = 0,
          double topY = 0,
          double bottomX = 0,
          double bottomY = 0}) =>
      BorderRadius.vertical(
          top: Radius.elliptical(topX, topY),
          bottom: Radius.elliptical(bottomX, bottomY));

  static BorderRadius onlyCircular({double top = 0, double bottom = 0}) =>
      BorderRadius.vertical(
          top: Radius.circular(top), bottom: Radius.circular(bottom));

  static BorderRadius top(
          {double x = mechanixRadius, double y = mechanixRadius}) =>
      BorderRadius.vertical(
          top: Radius.elliptical(x, y), bottom: Radius.elliptical(0, 0));

  static BorderRadius topAll([double top = mechanixRadius]) =>
      BorderRadius.vertical(
          top: Radius.elliptical(top, top), bottom: Radius.elliptical(0, 0));

  static BorderRadius bottom(
          {double x = mechanixRadius, double y = mechanixRadius}) =>
      BorderRadius.vertical(
          top: Radius.elliptical(0, 0), bottom: Radius.elliptical(x, y));

  static BorderRadius bottomAll([double bottom = mechanixRadius]) =>
      BorderRadius.vertical(
          top: Radius.elliptical(0, 0),
          bottom: Radius.elliptical(bottom, bottom));
}

extension RadiusCustom on BorderRadius {
  static BorderRadius only([
    Radius bottomLeft = Radius.zero,
    Radius bottomRight = Radius.zero,
    Radius topLeft = Radius.zero,
    Radius topRight = Radius.zero,
  ]) =>
      BorderRadius.only(
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        topLeft: topLeft,
        topRight: topRight,
      );
}
