// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadFailedState extends HistoryState {
  final String msg;
  HistoryLoadFailedState({
    required this.msg,
  });
}

class HistorySuccessState extends HistoryState {
  final Map<DateTime, List<RouteModel>> routes;

  HistorySuccessState({
    required this.routes,
  });
}
