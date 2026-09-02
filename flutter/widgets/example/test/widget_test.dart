import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mechanix_widgets/mechanix_widgets.dart';
import 'package:widgets_example/main.dart';

void main() {
  testWidgets('Verify Mechanix Widgets Example UI and Icons', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify AppBar title
    expect(find.text('Mechanix Widgets Example'), findsOneWidget);

    // Verify Host Platform card
    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text &&
                           widget.data!.startsWith('Host Platform:'),
      ),
      findsOneWidget,
    );

    // Verify MechanixIcons gallery presence
    expect(find.text('Mechanix Icons Gallery'), findsOneWidget);
    expect(find.byIcon(MechanixIcons.home), findsOneWidget);
    expect(find.byIcon(MechanixIcons.wifi), findsOneWidget);
    expect(find.byIcon(MechanixIcons.close), findsOneWidget);
  });
}
