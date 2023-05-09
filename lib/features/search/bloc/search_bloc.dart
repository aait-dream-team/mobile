import 'package:bus_navigation/features/search/repository/route_search_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../models/RouteResultModel.dart';

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
            final value = await repository.getSearchResults();
            emit(SearchSuccessState(result: value));
          } catch (e) {
            emit(SearchLoadFailedState(msg: e.toString()));
          }
        }
      },
    );
  }
}
