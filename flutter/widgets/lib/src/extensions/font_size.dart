import 'package:widgets/constants.dart';

extension FontSize on double {
  static const double xs = 12;

  static const double sm = 14;

  static const double md = 16;

  static const double lg = 18;

  static const double xl = 20;

  static double size([double value = mechanixFontSize]) => value;
}
