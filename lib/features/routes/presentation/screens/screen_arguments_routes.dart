import 'package:bus_navigation/features/routes/model/pin.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_argument.dart';

class ScreenArgumentsRoutes extends PinPoint implements ScreenArgument{
  final String type;
  ScreenArgumentsRoutes( {required this.type,required super.name, required super.location});
}