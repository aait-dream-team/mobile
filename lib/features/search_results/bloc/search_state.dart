part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadFailedState extends SearchState {
  final String msg;
  LatLng from, to;
  DateTime departureDate;

  SearchLoadFailedState(
      {required this.msg,
      required this.from,
      required this.to,
      required this.departureDate});
}

class SearchSuccessState extends SearchState {
  final List<RouteSearchResultModel> results;
  LatLng from, to;
  DateTime departureDate;

  SearchSuccessState(
      {required this.results,
      required this.from,
      required this.to,
      required this.departureDate});
}
