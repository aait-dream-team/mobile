import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../nav_detail/model/nav_detail_model.dart';
import '../models/RouteResultModel.dart';
import '../repository/route_search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RouteSearchRepository repository;

  SearchBloc({
    required this.repository,
  }) : super(SearchInitialState()) {
    on<SearchEvent>(
      (event, emit) async {
        if (event is LoadSearchEvent) {
          emit(SearchLoadingState());

          try {
            final value = await repository.getSearchResults(event.from,
                event.to, event.departureDate, event.isDepartureTime);
            emit(SearchSuccessState(
                results: value,
                from: event.from,
                to: event.to,
                departureDate: event.departureDate,
                isDepartureTime: event.isDepartureTime,
                fromPin: event.fromPin,
                toPin: event.toPin));
          } catch (e) {
            emit(SearchLoadFailedState(
                msg: e.toString(),
                from: event.from,
                to: event.to,
                departureDate: event.departureDate,
                isDepartureTime: event.isDepartureTime,
                fromPin: event.fromPin,
                toPin: event.toPin));
          }
        }
        if (event is InitSearch) {
          emit(SearchInitialState());
        }
      },
    );
  }
}
