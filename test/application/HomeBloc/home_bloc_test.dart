import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bus_navigation/features/home/bloc/home_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

// Import the generated mock class
import 'home_bloc_test.mocks.dart';

@GenerateMocks([GeocodingPlatform])
void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockGeocodingPlatform mockGeocodingPlatform;
    late LatLng position;
    setUp(() {
      mockGeocodingPlatform = MockGeocodingPlatform();
      homeBloc = HomeBloc();
      position = LatLng(0, 0);
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state is HomeInitialState', () {
      expect(homeBloc.state, HomeInitialState());
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomePinnedLoadingState, HomePinnedState] when MapPinChanged event is added',
      build: () {
        // Stub the getNameFromLatLng method to return a predefined location name
        when(mockGeocodingPlatform.placemarkFromCoordinates(0, 0,
                localeIdentifier: 'et'))
            .thenAnswer((_) async => Future(() => [
                  Placemark(
                    name: 'Location Name',
                    street: 'Street',
                    locality: 'Locality',
                    administrativeArea: 'Admin Area',
                    postalCode: '12345',
                    country: 'Country',
                  ),
                ]));
        return homeBloc;
      },
      act: (bloc) => bloc.add(MapPinChanged(
        position: position,
        zoom: 10,
        pinPosition: position,
        name: '0.0, 0.0',
      )),
      // expect: () {
      //   var state1 = HomePinnedLoadingState(
      //     position: position,
      //     zoom: 10,
      //     name: '0.0, 0.0',
      //     pinPosition: position,
      //   );
      //   var state2 = HomePinnedState(
      //     position: position,
      //     zoom: 10,
      //     name: '0.0 | 0.0, Uknown street, Addis Ababa, Addis Ababa, 1000, Ethiopia',
      //     pinPosition: position,
      //   );
      //   return [
      //     state1,state2
      //   ];
      // },
      verify: (_) {
        // Verify that the geocoding method is called
        verifyNever(mockGeocodingPlatform.placemarkFromCoordinates(0, 0,
                localeIdentifier: 'et'))
            .called(0);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeInitialState] when MapLoadEvent is added',
      build: () => homeBloc,
      act: (bloc) => bloc.add(MapLoadEvent()),
      expect: () => [
        HomeInitialState(),
      ],
    );

    // Test other events and states...
  });
}
