import 'package:bus_navigation/features/history/models/RouteHistory.dart';

final Map<DateTime, List<RouteModel>> mockdata = {
  DateTime.now(): [
    RouteModel(startPoint: "Home", endPoint: "Bole", date: DateTime.now()),
    RouteModel(startPoint: "Piassa", endPoint: "Asko", date: DateTime.now()),
    RouteModel(startPoint: "Home", endPoint: "4 Kilo", date: DateTime.now()),
    RouteModel(
        startPoint: "5 Kilo", endPoint: "Shiro Meda", date: DateTime.now()),
  ],
  DateTime(2021, 9, 1): [
    RouteModel(
        startPoint: "Home", endPoint: "Bole", date: DateTime(2021, 9, 1)),
    RouteModel(
        startPoint: "Piassa", endPoint: "Asko", date: DateTime(2021, 9, 1)),
    RouteModel(
        startPoint: "Home", endPoint: "4 Kilo", date: DateTime(2021, 9, 1)),
    RouteModel(
        startPoint: "5 Kilo",
        endPoint: "Shiro Meda",
        date: DateTime(2021, 9, 1)),
  ],
  DateTime(2021, 9, 2): [
    RouteModel(
        startPoint: "Home", endPoint: "Bole", date: DateTime(2021, 9, 2)),
    RouteModel(
        startPoint: "Piassa", endPoint: "Asko", date: DateTime(2021, 9, 2)),
    RouteModel(
        startPoint: "Home", endPoint: "4 Kilo", date: DateTime(2021, 9, 2)),
    RouteModel(
        startPoint: "5 Kilo",
        endPoint: "Shiro Meda",
        date: DateTime(2021, 9, 2)),
  ],
  DateTime(2021, 4, 5): [
    RouteModel(
        startPoint: "Home", endPoint: "Bole", date: DateTime(2021, 4, 5)),
    RouteModel(
        startPoint: "Piassa", endPoint: "Asko", date: DateTime(2021, 4, 5)),
    RouteModel(
        startPoint: "Home", endPoint: "4 Kilo", date: DateTime(2021, 4, 5)),
    RouteModel(
        startPoint: "5 Kilo",
        endPoint: "Shiro Meda",
        date: DateTime(2021, 4, 5)),
  ],
  DateTime(2021, 4, 6): [
    RouteModel(
        startPoint: "Home", endPoint: "Bole", date: DateTime(2021, 4, 6)),
    RouteModel(
        startPoint: "Piassa", endPoint: "Asko", date: DateTime(2021, 4, 6)),
    RouteModel(
        startPoint: "Home", endPoint: "4 Kilo", date: DateTime(2021, 4, 6)),
    RouteModel(
        startPoint: "5 Kilo",
        endPoint: "Shiro Meda",
        date: DateTime(2021, 4, 6)),
  ],
  DateTime(2021, 4, 7): [
    RouteModel(
        startPoint: "Home", endPoint: "Bole", date: DateTime(2021, 4, 7)),
    RouteModel(
        startPoint: "Piassa", endPoint: "Asko", date: DateTime(2021, 4, 7)),
    RouteModel(
        startPoint: "Home", endPoint: "4 Kilo", date: DateTime(2021, 4, 7)),
    RouteModel(
        startPoint: "5 Kilo",
        endPoint: "Shiro Meda",
        date: DateTime(2021, 4, 7)),
  ],
};
