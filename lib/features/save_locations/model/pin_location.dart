import 'package:bus_navigation/features/routes/models/pin.dart';

class PinLocation{
  final int id;
  final PinPoint location;
  final String name;
  final DateTime date;

  PinLocation({ required this.id,required this.date, required this.location, required this.name});

}