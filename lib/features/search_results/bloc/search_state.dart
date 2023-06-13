part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadFailedState extends SearchState {
  final String msg;
  final LatLng from, to;
  final DateTime departureDate;
  final bool isDepartureTime;

  SearchLoadFailedState(
      {required this.msg,
      required this.from,
      required this.to,
      required this.departureDate,
      required this.isDepartureTime});
}

class SearchSuccessState extends SearchState {
  final List<(RouteSearchResultModel, NavDetailModel)> results;
  final LatLng from, to;
  final DateTime departureDate;
  final bool isDepartureTime;

  SearchSuccessState(
      {required this.results,
      required this.from,
      required this.to,
      required this.departureDate,
      required this.isDepartureTime});
}
