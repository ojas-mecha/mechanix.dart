import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

void main() {
  group('MechanixIcons Font Tests', () {
    const allIcons = <String, IconData>{
      'close': MechanixIcons.close,
      'settings': MechanixIcons.settings,
      'wifi': MechanixIcons.wifi,
      'home': MechanixIcons.home,
      'search': MechanixIcons.search,
      'mecha': MechanixIcons.mecha,
      'bluetooth': MechanixIcons.bluetooth,
    };

    for (final entry in allIcons.entries) {
      testWidgets('Icon(MechanixIcons.${entry.key}) mounts and renders in widget tree',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Icon(entry.value, semanticLabel: entry.key),
            ),
          ),
        );

        final iconFinder = find.byIcon(entry.value);
        expect(iconFinder, findsOneWidget);

        final Icon iconWidget = tester.widget(iconFinder);
        expect(iconWidget.icon?.fontFamily, equals('MechanixIcons'));
        expect(iconWidget.icon?.fontPackage, equals('mechanix_widgets'));
        expect(find.bySemanticsLabel(entry.key), findsOneWidget);
      });
    }

    testWidgets('MechanixIcons respects custom size and color in IconTheme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: IconTheme(
              data: IconThemeData(
                color: Colors.amber,
                size: 48,
              ),
              child: Icon(MechanixIcons.mecha),
            ),
          ),
        ),
      );

      final iconFinder = find.byIcon(MechanixIcons.mecha);
      expect(iconFinder, findsOneWidget);

      final Icon iconWidget = tester.widget(iconFinder);
      expect(iconWidget.icon, equals(MechanixIcons.mecha));
    });

    test('MechanixIcons metadata and codepoints are valid and unique', () {
      expect(MechanixIcons.iconFontFamily, equals('MechanixIcons'));
      expect(MechanixIcons.iconFontPackage, equals('mechanix_widgets'));

      final codepoints = allIcons.values.map((i) => i.codePoint).toList();
      final uniqueCodepoints = codepoints.toSet();

      expect(uniqueCodepoints.length, equals(allIcons.length),
          reason: 'Every icon must have a unique codepoint');

      expect(MechanixIcons.close.codePoint, equals(0xe000));
      expect(MechanixIcons.settings.codePoint, equals(0xe001));
      expect(MechanixIcons.wifi.codePoint, equals(0xe002));
      expect(MechanixIcons.home.codePoint, equals(0xe003));
      expect(MechanixIcons.search.codePoint, equals(0xe004));
      expect(MechanixIcons.mecha.codePoint, equals(0xe005));
      expect(MechanixIcons.bluetooth.codePoint, equals(0xe006));
    });
  });
}
