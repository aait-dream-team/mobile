import 'package:bus_navigation/features/routes/bloc/routes_bloc.dart';
import 'package:bus_navigation/features/routes/data_provider/recent_route_data_provider.dart';
import 'package:bus_navigation/features/routes/presentation/screens/routes_page.dart';
import 'package:bus_navigation/features/routes/repository/recent_route_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRoutesBloc extends Mock implements RoutesBloc {}


void main() {
  late MockRoutesBloc mockRoutesBloc;

  setUp(() {
    mockRoutesBloc = MockRoutesBloc();
  });

  testWidgets('RoutesPage should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          // body: BlocProvider(create: BlocProvider<RoutesBloc>.value(value: RoutesBloc(recentRouteRepository: RecentRouteRepository(dataProvider:  RecentRouteDataProvider()))), child: RoutesPage() ,);
        ),
      ),
    );

    // Add your test assertions here
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byIcon(Icons.location_on), findsNWidgets(2));
    // Add more assertions based on your widget tree
  });
}