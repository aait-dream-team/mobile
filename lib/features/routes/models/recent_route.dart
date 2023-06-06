// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecentRouteModel {
  final String name;
  final String lat;
  final String long;
  final DateTime date;
  RecentRouteModel({
    required this.date,
    required this.name,
    required this.lat,
    required this.long,
  });

  RecentRouteModel copyWith({
    String? name,
    String? lat,
    String? long,
    DateTime? date
  }) {
    return RecentRouteModel(
      name: name ?? this.name,
      lat:  lat ?? this.lat,
      long: long ?? this.long,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'long': long,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory RecentRouteModel.fromMap(Map<String, dynamic> map) {
    return RecentRouteModel(
      name: map['name'] as String,
      lat: (map['lat'] as double).toString(),
      long: (map['long'] as double).toString(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentRouteModel.fromJson(String source) =>
      RecentRouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RecentRouteModel(name: $name, lat: $lat, long: $long, date: $date)';

  @override
  bool operator ==(covariant RecentRouteModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.lat == lat &&
        other.long == long && other.date == date;
  }

  @override
  int get hashCode => name.hashCode ^ lat.hashCode ^ long.hashCode ^ date.hashCode;
}
