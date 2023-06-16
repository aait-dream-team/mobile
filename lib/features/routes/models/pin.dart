import 'package:latlong2/latlong.dart';
import 'package:equatable/equatable.dart';

class PinPoint extends Equatable{
  final String name;
  final LatLng location;

  const PinPoint({required this.name, required this.location});
  
  @override
  // TODO: implement props
  List<Object?> get props => [name, location];
}
