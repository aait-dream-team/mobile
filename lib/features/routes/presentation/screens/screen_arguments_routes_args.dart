import 'package:bus_navigation/features/routes/presentation/screens/screen_argument.dart';

class ScreenArgumentsRoutesArgs implements ScreenArgument {
  final String name;
  final Function func;

  ScreenArgumentsRoutesArgs({
    required this.name,
    required this.func
  });
}