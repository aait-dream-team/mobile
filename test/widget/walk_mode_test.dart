import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/train_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Leg leg = Leg(
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    routeShortName: 'BUS123', mode: 'BUS', from: 'Shiromeda', to: 'Mexico', duration: 23, legGeometry: 'point',
  );
  const index = 1;
  const currentIndex = 0;

  testWidgets('WalkMode widget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WalkMode(
            leg: leg,
            index: index,
            currentIndex: currentIndex,
          ),
        ),
      ),
    );

    // Verify that the container is displayed correctly
    expect(find.byType(Container), findsOneWidget);

    // Verify that the expected number of Center widgets are present
    expect(find.byWidgetPredicate((widget) => widget is Center), findsNWidgets(2));

    // Verify the Icon widget
    expect(find.byIcon(Icons.directions_walk), findsOneWidget);

    // Verify the decoration based on the index and currentIndex
    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration;
    if (index > currentIndex) {
      expect(decoration.color, equals(Colors.white));
    } else if (index < currentIndex) {
      expect(decoration.color, equals(Color.fromARGB(255, 213, 210, 210)));
    } else {
      expect(decoration.color, equals(Color.fromARGB(255, 105, 211, 109)));
    }
  });
}
