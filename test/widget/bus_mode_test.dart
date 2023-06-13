import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/bus_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BusMode widget displays correctly', (WidgetTester tester) async {
    Leg leg = Leg(
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    routeShortName: 'BUS123', mode: 'BUS', from: 'Shiromeda', to: 'Mexico', duration: 23, legGeometry: 'point',
  );
    const index = 0;
    const currentIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: BusMode(
          leg: leg,
          index: index,
          currentIndex: currentIndex,
        ),
      ),
    );

    expect(find.text('8:30'), findsOneWidget); // Verify the start time is displayed correctly
    expect(find.text('Bus 123'), findsOneWidget); // Verify the route short name is displayed correctly
    expect(find.byType(Container), findsNWidgets(3)); // Verify the presence of Container widgets
    expect(find.byType(Icon), findsOneWidget); // Verify the presence of an Icon widget
    expect(find.byType(Card), findsOneWidget); // Verify the presence of a Card widget
  });
}
