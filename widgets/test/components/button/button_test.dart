import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixButton Widget Tests', () {
    testWidgets('renders filled, outline, and text button variants', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixButton.filled(
                  labelText: 'Filled Button',
                  onPressed: () {},
                ),
                MechanixButton.outline(
                  labelText: 'Outline Button',
                  onPressed: () {},
                ),
                MechanixButton.text(
                  labelText: 'Text Button',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled Button'), findsOneWidget);
      expect(find.text('Outline Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('handles tap events when enabled', (WidgetTester tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixButton.text(
              labelText: 'Tap Me',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('respects disabled state when onPressed is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixButton.filled(
                  labelText: 'Disabled Filled',
                  onPressed: null,
                ),
                MechanixButton.text(
                  labelText: 'Disabled Text',
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      );

      final filledButton = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(filledButton.onPressed, isNull);

      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      expect(textButton.onPressed, isNull);
    });

    testWidgets('resolves correct background and foreground colors for text button states', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: MechanixButton.text(
              labelText: 'Hover Test',
              onPressed: () {},
            ),
          ),
        ),
      );

      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      final style = textButton.style!;

      // Background is transparent in all states
      expect(style.backgroundColor?.resolve({}), Colors.transparent);
      expect(style.backgroundColor?.resolve({WidgetState.hovered}), Colors.transparent);
      expect(style.backgroundColor?.resolve({WidgetState.pressed}), Colors.transparent);

      // Foreground is onSurface for normal/enabled/pressed/focused, onSecondaryContainer for hovered
      final lightScheme = MechanixTheme.lightColorScheme;
      expect(style.foregroundColor?.resolve({}), lightScheme.onSurface);
      expect(style.foregroundColor?.resolve({WidgetState.pressed}), lightScheme.onSurface);
      expect(style.foregroundColor?.resolve({WidgetState.focused}), lightScheme.onSurface);
      expect(style.foregroundColor?.resolve({WidgetState.hovered}), lightScheme.onSecondaryContainer);
    });

    testWidgets('supports labelText string and custom label widget (with label taking precedence)', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixButton.filled(
                  labelText: 'String Label',
                  onPressed: () {},
                ),
                MechanixButton.filled(
                  label: const Text('Widget Label'),
                  onPressed: () {},
                ),
                MechanixButton.filled(
                  labelText: 'Ignored Text',
                  label: const Text('Overriding Widget'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('String Label'), findsOneWidget);
      expect(find.text('Widget Label'), findsOneWidget);
      expect(find.text('Overriding Widget'), findsOneWidget);
      expect(find.text('Ignored Text'), findsNothing);
    });

    testWidgets('adapts to text scaling without overflow in hug sizing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2.5)),
            child: Scaffold(
              body: MechanixButton.filled(
                size: ButtonSize.xSmall,
                labelText: 'Scaled Button Text',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('Scaled Button Text'), findsOneWidget);

      final buttonRenderBox = tester.renderObject<RenderBox>(find.byType(MechanixButton));
      // xSmall base height is 28, with 2.5x scaling it expands naturally without overflow
      expect(buttonRenderBox.size.height, greaterThan(28.0));
    });
  });
}

