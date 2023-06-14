// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:latlong2/latlong.dart';

class Step {
  final double distance;
  final String relativeDirection;
  final String streetName;

  Step(
      {required this.distance,
      required this.relativeDirection,
      required this.streetName});
}

class IntermediateStop {
  final String name;
  final LatLng location;
  final DateTime arrivalTime;
  final DateTime departureTime;

  IntermediateStop(
      {required this.name,
      required this.location,
      required this.arrivalTime,
      required this.departureTime});

  factory IntermediateStop.fromMap(Map<String, dynamic> map) {
    return IntermediateStop(
        name: map["name"] as String,
        location: LatLng(map["lat"] as double, map["lon"] as double),
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(map["arrival"] as int),
        departureTime:
            DateTime.fromMillisecondsSinceEpoch(map["departure"] as int));
  }
}

class Alert {
  final String alertText;
  final int startDate;
  final int endDate;

  Alert(
      {required this.alertText,
      required this.startDate,
      required this.endDate});

  factory Alert.fromMap(Map<String, dynamic> map) {
    return Alert(
        alertText: map["alertHeaderText"],
        startDate: map["effectiveStartDate"],
        endDate: map["effectiveEndDate"]);
  }
}

class Leg {
  final String? routeId;
  final String? agencyId;
  final String? tripId;
  final DateTime startTime; // legs[i].startTime
  final DateTime endTime;
  final String mode;
  final String from;
  final String to;
  final double duration;
  final String legGeometry;
  final List<IntermediateStop>? intermidateStops;
  final List<Alert>? alerts;
  final double? distance;
  final String? routeShortName;
  final String? routeLongName;
  final String? agencyName;
  final List<Step>? steps;

  Leg({
    required this.startTime,
    required this.endTime,
    required this.mode,
    required this.from,
    required this.to,
    required this.duration,
    required this.legGeometry,
    this.intermidateStops,
    this.distance,
    this.routeShortName,
    this.routeLongName,
    this.agencyName,
    this.steps,
    this.routeId,
    this.agencyId,
    this.tripId,
    this.alerts,
  });

  factory Leg.fromMap(Map<String, dynamic> map) {
    return Leg(
      agencyId: map['mode'] != 'WALK'
          ? (map['agencyId'] as String).substring(2).replaceAll(':', "-")
          : null,
      tripId: map['mode'] != 'WALK'
          ? (map['tripId'] as String).substring(2).replaceAll(':', "-")
          : null,
      routeId: map['mode'] != 'WALK'
          ? (map['routeId'] as String).substring(2).replaceAll(':', "-")
          : null,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      mode: map['mode'] as String,
      from: map['from']['name'] as String,
      to: map['to']['name'] as String,
      duration: map['duration'] as double,
      legGeometry: map['legGeometry']['points'] as String,
      intermidateStops: (map['intermediateStops'] != null)
          ? (map['intermediateStops'] as List)
              .map((e) => IntermediateStop.fromMap(e))
              .toList()
          : null,
      alerts: (map['alerts'] != null)
          ? (map['alerts'] as List).map((e) => Alert.fromMap(e)).toList()
          : null,
      distance: map['distance'] as double,
      routeShortName: (map['routeShortName']).toString(),
      routeLongName: (map['routeLongName']).toString(),
      agencyName: (map['agencyName']).toString(),
      steps: List<Step>.from(
        (map['steps'] as List).map(
          (x) => Step(
            distance: x['distance'] as double,
            relativeDirection: x['relativeDirection'] as String,
            streetName: x['streetName'] as String,
          ),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'Leg(startTime: $startTime, endTime: $endTime, mode: $mode, from: $from, to: $to, duration: $duration, distance: $distance, tripId: $tripId, routeId: $routeId, agencyId: $agencyId)';
  }
}

class NavDetailModel {
  final DateTime startTime; // startTime
  final DateTime endTime; // endTime
  final int duration; // duration
  final List<Leg> legs; // legs

  NavDetailModel({
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.legs,
  });

  factory NavDetailModel.fromMap(Map<String, dynamic> map) {
    return NavDetailModel(
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      duration: map['duration'] as int,
      legs: List<Leg>.from(
        (map['legs'] as List).map(
          (x) => Leg.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'NavDetailModel(startTime: $startTime, endTime: $endTime, duration: $duration, legs: $legs)';
  }
}
