import 'package:bloc_test/bloc_test.dart';
import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:bus_navigation/features/navigate/bloc/navigation_bloc.dart';
import 'package:bus_navigation/features/navigate/repository/navigation_repository.dart';
import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'navigate_bloc_test.mocks.dart';

@GenerateMocks([NavigationRepository])
void main() {
  group('NavigationBloc', () {
    late NavigationBloc navigationBloc;
    late MockNavigationRepository mockRepository;
    late PinPoint pin;
    late NavDetailModel navDetailModel;

    setUp(() {
      mockRepository = MockNavigationRepository();
      navigationBloc = NavigationBloc(repository: mockRepository);
      pin = PinPoint(name: 'Location A', location: LatLng(0, 0));
      var time = DateTime.now();
      navDetailModel =  NavDetailModel(startTime: time, endTime: time,legs: [], duration: 0);
    });

    tearDown(() {
      navigationBloc.close();
    });

    test('initial state is NavigationInitialState', () {
      expect(navigationBloc.state, NavigationInitialState());
    });

    // blocTest<NavigationBloc, NavigationState>(
    //   'emits [NavigationLoadingState, NavigationSuccessState] when LoadNavigationEvent is added',
    //   build: () => navigationBloc,
    //   act: (bloc) => bloc.add(LoadNavigationEvent(
    //       polylineString: ['polyline1', 'polyline2'],
    //       navDetailModel: navDetailModel,
    //       fromPin: pin,
    //       toPin: pin)),
    //   expect: () => [
    //     NavigationLoadingState(),
    //     // NavigationSuccessState(
    //     //     routePoints: [],
    //     //     navDetailModel: navDetailModel,
    //     //     fromPin: pin,
    //     //     toPin: pin),
    //   ],
    // );

    // // Add more bloc tests for other events and states

  });
}
