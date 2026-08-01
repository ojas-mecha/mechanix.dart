import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

void main() {
  group('MechanixThemeData Tests', () {
    test('Default MechanixThemeData initializes properly', () {
      const themeData = MechanixThemeData();
      expect(themeData.themeMode, equals(ThemeMode.dark));
      expect(themeData.mechanixVariant, isNull);
    });

    test('MechanixThemeData resolves light and dark themes', () {
      const themeData = MechanixThemeData(
        mechanixVariant: MechanixVariant.blue,
      );

      final lightTheme = themeData.lightTheme;
      final darkTheme = themeData.darkTheme;

      expect(lightTheme, isNotNull);
      expect(darkTheme, isNotNull);
    });
  });

  group('MechanixTheme Widget Tests', () {
    testWidgets('MechanixTheme provides MechanixThemeData via context',
        (WidgetTester tester) async {
      MechanixThemeData? capturedData;

      await tester.pumpWidget(
        MechanixTheme(
          data: const MechanixThemeData(
            mechanixVariant: MechanixVariant.purple,
          ),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                capturedData = MechanixTheme.maybeOf(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(capturedData, isNotNull);
      expect(capturedData?.mechanixVariant, equals(MechanixVariant.purple));
    });
  });
}
