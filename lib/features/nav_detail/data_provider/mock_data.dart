import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';

NavDetailModel navDetailModel = NavDetailModel(
  startTime: DateTime.utc(2023),
  endTime: DateTime.now(),
  duration: 120,
  legs: [
    Leg(
      startTime: DateTime(2023, 02, 02, 4, 30, 7, 6),
      endTime: DateTime.now(),
      mode: 'BUS',
      from: 'Piassa',
      to: '4 Kilo',
      duration: 30,
    ),
    Leg(
      startTime: DateTime(2023, 02, 02, 4, 30, 7, 6),
      endTime: DateTime.now(),
      mode: 'BUS',
      from: 'Piassa',
      to: '4 Kilo',
      duration: 30,
    ),
  ],
);
