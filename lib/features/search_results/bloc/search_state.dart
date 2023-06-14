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
  final PinPoint fromPin, toPin;

  SearchLoadFailedState(
      {required this.msg,
      required this.from,
      required this.to,
      required this.departureDate,
      required this.isDepartureTime,
      required this.fromPin,
      required this.toPin});
}

class SearchSuccessState extends SearchState {
  final List<(RouteSearchResultModel, NavDetailModel)> results;
  final LatLng from, to;
  final PinPoint fromPin, toPin;
  final DateTime departureDate;
  final bool isDepartureTime;

  SearchSuccessState(
      {required this.results,
      required this.from,
      required this.to,
      required this.departureDate,
      required this.isDepartureTime,
      required this.fromPin,
      required this.toPin});
}
