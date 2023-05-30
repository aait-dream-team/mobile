part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class LoadSearchEvent extends SearchEvent {
  final LatLng from, to;
  final DateTime departureDate;

  LoadSearchEvent(
      {required this.from, required this.to, required this.departureDate});
}
