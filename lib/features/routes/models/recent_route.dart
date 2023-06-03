// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecentRouteModel {
  final String name;
  final String lat;
  final String long;
  RecentRouteModel({
    required this.name,
    required this.lat,
    required this.long,
  });

  RecentRouteModel copyWith({
    String? startPoint,
    String? endPoint,
    String? date,
  }) {
    return RecentRouteModel(
      name: startPoint ?? name,
      lat: endPoint ?? lat,
      long: date ?? long,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'long': long,
    };
  }

  factory RecentRouteModel.fromMap(Map<String, dynamic> map) {
    return RecentRouteModel(
      name: map['name'] as String,
      lat: map['lat'] as String,
      long: map['long'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentRouteModel.fromJson(String source) =>
      RecentRouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RecentRouteModel(name: $name, lat: $lat, long: $long)';

  @override
  bool operator ==(covariant RecentRouteModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.lat == lat &&
        other.long == long;
  }

  @override
  int get hashCode => name.hashCode ^ lat.hashCode ^ long.hashCode;
}
