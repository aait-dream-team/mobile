import 'package:bus_navigation/features/navigate/repository/navigation_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final NavigationRepository repository;

  NavigationBloc({required this.repository}) : super(NavigationInitialState()) {
    on<NavigationEvent>((event, emit) async {
      if (event is LoadNavigationEvent) {
        emit(NavigationLoadingState());

        final value = await repository.getRouteDetails();
        emit(NavigationSuccessState(legs: value));
      }
    });
  }
}
