import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';

void main() {
  group('MechanixElevatedButton Widget Tests', () {
    testWidgets('Renders label and responds to tap events',
        (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixElevatedButton(
              label: 'Submit',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);

      await tester.tap(find.byType(MechanixElevatedButton));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });
}
