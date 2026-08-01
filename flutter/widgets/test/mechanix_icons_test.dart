import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

void main() {
  group('MechanixIcons Font Tests', () {
    testWidgets('Icon(MechanixIcons.home) renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Icon(MechanixIcons.home),
          ),
        ),
      );

      final iconFinder = find.byIcon(MechanixIcons.home);
      expect(iconFinder, findsOneWidget);

      final Icon iconWidget = tester.widget(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals('MechanixIcons'));
      expect(iconWidget.icon?.fontPackage, equals('mechanix_widgets'));
    });

    testWidgets('Icon(MechanixIcons.wifi) renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Icon(MechanixIcons.wifi),
          ),
        ),
      );

      final iconFinder = find.byIcon(MechanixIcons.wifi);
      expect(iconFinder, findsOneWidget);
    });
  });
}
