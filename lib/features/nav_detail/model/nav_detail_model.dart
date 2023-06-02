// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Step {
  final double distance;
  final String relativeDirection;
  final String streetName;

  Step(
      {required this.distance,
      required this.relativeDirection,
      required this.streetName});
}

class Leg {
  final DateTime startTime; // legs[i].startTime
  final DateTime endTime;
  final String mode;
  final String from;
  final String to;
  final double duration;
  final String legGeometry;
  final double? distance;
  final String? routeShortName;
  final String? routeLongName;
  final String? agencyName;
  final List<Step>? steps;

  Leg(
      {required this.startTime,
      required this.endTime,
      required this.mode,
      required this.from,
      required this.to,
      required this.duration,
      required this.legGeometry,
      this.distance,
      this.routeShortName,
      this.routeLongName,
      this.agencyName,
      this.steps});

  factory Leg.fromMap(Map<String, dynamic> map) {
    return Leg(
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      mode: map['mode'] as String,
      from: map['from']['name'] as String,
      to: map['to']['name'] as String,
      duration: map['duration'] as double,
      legGeometry: map['legGeometry']['points'] as String,
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
    return 'Leg(startTime: $startTime, endTime: $endTime, mode: $mode, from: $from, to: $to, duration: $duration, distance: $distance)';
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
