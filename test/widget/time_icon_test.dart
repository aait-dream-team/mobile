import 'package:bus_navigation/features/nav_detail/presentation/widgets/time_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:your_app_name/time_icon.dart';

void main() {
  testWidgets('TimeIcon displays correctly', (WidgetTester tester) async {
    // Build the TimeIcon widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimeIcon(
            type: TimeType.start,
            time: '10:00 AM',
          ),
        ),
      ),
    );

    // Find the Chip widget
    final chipFinder = find.byType(Chip);
    expect(chipFinder, findsOneWidget);

    // Verify the background color of the Chip
    final chipWidget = tester.widget<Chip>(chipFinder);
    expect(chipWidget.backgroundColor, equals(Colors.green));

    // Find the Text widget
    final textFinder = find.text('10:00 AM');
    expect(textFinder, findsOneWidget);

    // Verify the text color of the Text widget
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style!.color, equals(Colors.white));
  });
}
