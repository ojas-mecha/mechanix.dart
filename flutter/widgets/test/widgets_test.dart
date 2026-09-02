import 'package:flutter_test/flutter_test.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';
import 'package:mechanix_widgets/widgets_platform_interface.dart';
import 'package:mechanix_widgets/widgets_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWidgetsPlatform
    with MockPlatformInterfaceMixin
    implements WidgetsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

class ExtendsWidgetsPlatform extends WidgetsPlatform {}

void main() {
  final WidgetsPlatform initialPlatform = WidgetsPlatform.instance;

  test('$MethodChannelWidgets is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWidgets>());
  });

  test('MechanixPlatform.getPlatformVersion returns value from registered platform', () async {
    MockWidgetsPlatform fakePlatform = MockWidgetsPlatform();
    WidgetsPlatform.instance = fakePlatform;

    expect(await MechanixPlatform.getPlatformVersion(), '42');
  });

  test('WidgetsPlatform default implementation throws UnimplementedError with correct method name', () {
    final platform = ExtendsWidgetsPlatform();
    expect(
      () => platform.getPlatformVersion(),
      throwsA(isA<UnimplementedError>().having(
        (e) => e.message,
        'message',
        equals('getPlatformVersion() has not been implemented.'),
      )),
    );
  });
}
