import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bus_navigation/features/history/bloc/history_bloc.dart';
import 'package:bus_navigation/features/history/repository/route_history_repository.dart';
import 'package:bus_navigation/features/history/models/RouteHistory.dart';

// import 'history_bloc.mocks.dart';

// Import the generated mock classes
import 'history_bloc_test.mocks.dart';

@GenerateMocks([RouteHistoryRepository]) // Generate mock classes

void main() {
  group('HistoryBloc', () {
    late HistoryBloc historyBloc;
    late MockRouteHistoryRepository mockRepository;
    late RouteModel route;

    setUp(() {
      mockRepository = MockRouteHistoryRepository();
      historyBloc = HistoryBloc(repository: mockRepository);
      route = RouteModel(
          startPoint: "Location A",
          endPoint: "Location B",
          date: DateTime.now());
    });

    tearDown(() {
      historyBloc.close();
    });

    test('initial state is HistoryInitialState', () {
      expect(historyBloc.state, HistoryInitialState());
    });

    blocTest<HistoryBloc, HistoryState>(
      'emits [HistoryLoadingState, HistorySuccessState] when LoadHistoryEvent is added',
      build: () {
        // Stub the getAllRoutes method to return a predefined map of routes
        when(mockRepository.getAllRoutes()).thenAnswer(
          (_) async => {
            DateTime(2022, 1, 1): [route, route],
            DateTime(2022, 1, 2): [route],
          },
        );
        return historyBloc;
      },
      act: (bloc) => bloc.add(LoadHistoryEvent()),
      expect: () => [
        HistoryLoadingState(),
        HistorySuccessState(
          routes: {
            DateTime(2022, 1, 1): [route, route],
            DateTime(2022, 1, 2): [route],
          },
        ),
      ],
      verify: (_) {
        // Verify that the repository method is called
        verify(mockRepository.getAllRoutes()).called(1);
      },
    );

    blocTest<HistoryBloc, HistoryState>(
      'emits [HistoryLoadingState, HistoryLoadFailedState] when LoadHistoryEvent throws an exception',
      build: () => historyBloc,
      act: (bloc) {
        when(mockRepository.getAllRoutes())
            .thenThrow(Exception('Failed to load history'));
        bloc.add(LoadHistoryEvent());
      },
      expect: () => [
        HistoryLoadingState(),
        HistoryLoadFailedState(msg: 'Exception: Failed to load history'),
      ],
      verify: (_) {
        // Verify that the repository method is called
        verify(mockRepository.getAllRoutes()).called(1);
      },
    );
  });
}
