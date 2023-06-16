// import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bus_navigation/features/routes/bloc/routes_bloc.dart';
import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';
import 'package:bus_navigation/features/routes/repository/recent_route_repository.dart';

// Import the generated mock classes
import 'routes_bloc_test.mocks.dart';

@GenerateMocks([RecentRouteRepository]) // Generate mock classes

void main() {
  group('RoutesBloc', () {
    late RoutesBloc routesBloc;
    late MockRecentRouteRepository mockRepository;
    late DateTime time;
    late RecentRouteModel recentRoute;
    late PinPoint pin;

    setUp(() {
      mockRepository = MockRecentRouteRepository();
      routesBloc = RoutesBloc(recentRouteRepository: mockRepository);
      time = DateTime.now();
      pin = PinPoint(name: 'Location A', location: LatLng(0, 0));
      recentRoute = RecentRouteModel(
        name: pin.name,
        lat: pin.location.latitude.toString(),
        long: pin.location.longitude.toString(),
        date: time,
      );
    });

    tearDown(() {
      routesBloc.close();
    });

    test('initial state is RoutesInitial', () {
      expect(routesBloc.state, const RoutesInitial(routes: []));
    });

    blocTest<RoutesBloc, RoutesState>(
      'emits [RoutesPinPoint] when PointPicked event is added',
      build: () => routesBloc,
      act: (bloc) => bloc.add(PointPicked(
        from: PinPoint(name: 'Location A', location: LatLng(0, 0)),
        to: PinPoint(name: 'Location B', location: LatLng(1, 1)),
        datetime: time,
        isDepartureTime: true,
      )),
      expect: () => [
        RoutesPinPoint(
          from: PinPoint(name: 'Location A', location: LatLng(0, 0)),
          to: PinPoint(name: 'Location B', location: LatLng(1, 1)),
          datetime: time,
          routes: [],
          isDepartureTime: true,
        ),
      ],
    );

    blocTest<RoutesBloc, RoutesState>(
      'emits [RoutesLoading, RoutesLoaded] when FetchRecentRoute event is added',
      build: () {
        // Stub the getAllRoutes method to return a list of recent routes
        when(mockRepository.getAllRoutes()).thenAnswer(
          (_) async => [
            RecentRouteModel(
              name: 'Location X',
              lat: '0.0',
              long: '0.0',
              date: time,
            ),
            RecentRouteModel(
              name: 'Location Y',
              lat: '1.0',
              long: '1.0',
              date: time,
            ),
          ],
        );
        return routesBloc;
      },
      act: (bloc) => bloc.add(FetchRecentRoute()),
      expect: () => [
        RoutesLoading(routes: []),
        RoutesLoaded(
          routes: [
            RecentRouteModel(
              name: 'Location X',
              lat: '0.0',
              long: '0.0',
              date: time,
            ),
            RecentRouteModel(
              name: 'Location Y',
              lat: '1.0',
              long: '1.0',
              date: time,
            ),
          ],
        ),
      ],
      verify: (_) {
        // Verify that the repository method is called
        verify(mockRepository.getAllRoutes()).called(1);
      },
    );

    blocTest<RoutesBloc, RoutesState>(
      'adds recent routes when PointPicked event is added',
      build: () {
        // Stub the getAllRoutes method to return a list of recent routes
        when(mockRepository.addRecentRoute(recentRoute))
            .thenAnswer((_) async => Future(() => null));
        return routesBloc;
      },
      act: (bloc) async {
        // Arrange
        final fromPin = PinPoint(name: 'Location A', location: LatLng(0, 0));
        final toPin = PinPoint(name: 'Location B', location: LatLng(1, 1));
        final dateTime = DateTime.now();
        final isDepartureTime = true;
        final recentRouteA = RecentRouteModel(
          name: fromPin.name,
          lat: fromPin.location.latitude.toString(),
          long: fromPin.location.longitude.toString(),
          date: dateTime,
        );
        final recentRouteB = RecentRouteModel(
          name: toPin.name,
          lat: toPin.location.latitude.toString(),
          long: toPin.location.longitude.toString(),
          date: dateTime,
        );

        // Act
        bloc.add(PointPicked(
          from: pin,
          to: pin,
          datetime: time,
          isDepartureTime: isDepartureTime,
        ));
  
        // Assert

        // verifyNever(mockRepository.addRecentRoute(recentRoute)).called(0);
        // verify(mockRepository.addRecentRoute(recentRoute)).called(1);
      
      },
      verify: (_) {
        verify(mockRepository.addRecentRoute(recentRoute)).called(2);

      },
      expect: () {
        return [
          RoutesPinPoint(
            from: pin,
            to: pin,
            datetime: time,
            routes: [],
            isDepartureTime: true,
          ),
        ];

      }
    );

     blocTest<RoutesBloc, RoutesState>(
      'emits RoutesPinPoint when PointPicked event is added',
      build: () {
        // Stub the getAllRoutes method to return a list of recent routes
        when(mockRepository.addRecentRoute(recentRoute))
            .thenAnswer((_) async => Future(() => null));
        return routesBloc;
      },
      act: (bloc) async {
        // Arrange
        final fromPin = PinPoint(name: 'Location A', location: LatLng(0, 0));
        final toPin = PinPoint(name: 'Location B', location: LatLng(1, 1));
        final dateTime = DateTime.now();
        final isDepartureTime = true;
        final recentRouteA = RecentRouteModel(
          name: fromPin.name,
          lat: fromPin.location.latitude.toString(),
          long: fromPin.location.longitude.toString(),
          date: dateTime,
        );
        final recentRouteB = RecentRouteModel(
          name: toPin.name,
          lat: toPin.location.latitude.toString(),
          long: toPin.location.longitude.toString(),
          date: dateTime,
        );

        // Act
        bloc.add(PointPicked(
          from: pin,
          to: pin,
          datetime: time,
          isDepartureTime: isDepartureTime,
        ));
  
        // Assert

        // verifyNever(mockRepository.addRecentRoute(recentRoute)).called(0);
        // verify(mockRepository.addRecentRoute(recentRoute)).called(1);
      
      }, 
      expect: () {
        return [
          RoutesPinPoint(
            from: pin,
            to: pin,
            datetime: time,
            routes: [],
            isDepartureTime: true,
          ),
        ];

      }
    );
  
  });

  // blocTest<RoutesBloc, RoutesState>(
  //     'adds recent routes when PointPicked event is added',
  //     build: () => routesBloc,
  //     act: (bloc) async {
  //       // Arrange
  //       final fromPin = PinPoint(name: 'Location A', location: LatLng(0, 0));
  //       final toPin = PinPoint(name: 'Location B', location: LatLng(1, 1));
  //       final dateTime = DateTime.now();
  //       final isDepartureTime = true;
  //       final recentRouteA = RecentRouteModel(
  //         name: fromPin.name,
  //         lat: fromPin.location.latitude.toString(),
  //         long: fromPin.location.longitude.toString(),
  //         date: dateTime,
  //       );
  //       final recentRouteB = RecentRouteModel(
  //         name: toPin.name,
  //         lat: toPin.location.latitude.toString(),
  //         long: toPin.location.longitude.toString(),
  //         date: dateTime,
  //       );

  //       // Act
  //       await bloc.add(PointPicked(
  //         from: fromPin,
  //         to: toPin,
  //         datetime: dateTime,
  //         isDepartureTime: isDepartureTime,
  //       ));

  //       // Assert
  //       verify(mockRepository.addRecentRoute(recentRouteA)).called(1);
  //       verify(mockRepository.addRecentRoute(recentRouteB)).called(1);
  //     },
  //   );
}
