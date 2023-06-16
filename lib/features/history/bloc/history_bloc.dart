// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bus_navigation/features/history/repository/route_history_repository.dart';
import 'package:equatable/equatable.dart';

import '../models/RouteHistory.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final RouteHistoryRepository repository;

  HistoryBloc({
    required this.repository,
  }) : super(HistoryInitialState()) {
    on<HistoryEvent>((event, emit) async {
      if (event is LoadHistoryEvent) {
        emit(HistoryLoadingState());

        try {
          final  value = await repository.getAllRoutes();

          emit(HistorySuccessState(routes: value));
        } catch (e) {
          emit(HistoryLoadFailedState(msg: e.toString()));
        }
      }
    });
  }
}
