import 'package:mechanix_widgets/widgets_platform_interface.dart';

/// Platform utility methods for Mechanix.
class MechanixPlatform {
  const MechanixPlatform._();

  /// Gets the host platform version string (e.g. 'eLinux').
  static Future<String?> getPlatformVersion() {
    return WidgetsPlatform.instance.getPlatformVersion();
  }
}
