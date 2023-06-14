part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class InitSearch extends SearchEvent {}

class LoadSearchEvent extends SearchEvent {
  final PinPoint fromPin, toPin;
  final LatLng from, to;
  final DateTime departureDate;
  final bool isDepartureTime;

  LoadSearchEvent(
      {required this.from,
      required this.to,
      required this.departureDate,
      required this.isDepartureTime,
      required this.fromPin,
      required this.toPin});
}
