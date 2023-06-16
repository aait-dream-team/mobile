import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bus_navigation/main.dart' as app;

// flutter drive  --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("full app test", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 20));

      // Verify the counter starts at 0.
      // expect(find.text('Location'), findsOneWidget);
      // await tester.pumpAndSettle();

      // var search_home = find.byKey(Key('search_home'));
      // await tester.tap(search_home);
      // await Future.delayed(Duration(seconds: 3));
      // await Future.delayed(Duration(seconds: 3));
      // await tester.pumpAndSettle();
      // await tester.pumpAndSettle();
    });
  });
}
