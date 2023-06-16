// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class RouteModel extends Equatable {
  final String startPoint;
  final String endPoint;
  final DateTime date;
  RouteModel({
    required this.startPoint,
    required this.endPoint,
    required this.date,
  });

  RouteModel copyWith({
    String? startPoint,
    String? endPoint,
    DateTime? date,
  }) {
    return RouteModel(
      startPoint: startPoint ?? this.startPoint,
      endPoint: endPoint ?? this.endPoint,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startPoint': startPoint,
      'endPoint': endPoint,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      startPoint: map['startPoint'] as String,
      endPoint: map['endPoint'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) =>
      RouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RouteModel(startPoint: $startPoint, endPoint: $endPoint, date: $date)';

  @override
  bool operator ==(covariant RouteModel other) {
    if (identical(this, other)) return true;

    return other.startPoint == startPoint &&
        other.endPoint == endPoint &&
        other.date == date;
  }

  @override
  int get hashCode => startPoint.hashCode ^ endPoint.hashCode ^ date.hashCode;
  
  @override
  // TODO: implement props
  List<Object?> get props => [startPoint, endPoint, date];
}
