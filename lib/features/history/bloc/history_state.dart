// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {}

class HistoryInitialState extends HistoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HistoryLoadingState extends HistoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HistoryLoadFailedState extends HistoryState {
  final String msg;
  HistoryLoadFailedState({
    required this.msg,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}

class HistorySuccessState extends HistoryState {
  final Map<DateTime, List<RouteModel>> routes;

  HistorySuccessState({
    required this.routes,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [routes];
}
