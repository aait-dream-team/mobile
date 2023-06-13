part of 'locations_bloc.dart';

@immutable
abstract class LocationsEvent {
}


class SaveLocation extends LocationsEvent{
  final PinPoint location;
  final String name ;
  SaveLocation({required this.name, required this.location});
}

class FetchLocation extends LocationsEvent{

}

class DeleteLocation extends LocationsEvent{
  final int id;
  DeleteLocation({required this.id});
}