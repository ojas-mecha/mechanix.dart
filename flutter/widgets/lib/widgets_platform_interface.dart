import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'widgets_method_channel.dart';

abstract class WidgetsPlatform extends PlatformInterface {
  /// Constructs a WidgetsPlatform.
  WidgetsPlatform() : super(token: _token);

  static final Object _token = Object();

  static WidgetsPlatform _instance = MethodChannelWidgets();

  /// The default instance of [WidgetsPlatform] to use.
  ///
  /// Defaults to [MethodChannelWidgets].
  static WidgetsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WidgetsPlatform] when
  /// they register themselves.
  static set instance(WidgetsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }
}
