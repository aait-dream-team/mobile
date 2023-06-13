part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class InitSearch extends SearchEvent {}

class LoadSearchEvent extends SearchEvent {
  final LatLng from, to;
  final DateTime departureDate;
  final bool isDepartureTime;

  LoadSearchEvent(
      {required this.from, required this.to, required this.departureDate, required this.isDepartureTime});
}
