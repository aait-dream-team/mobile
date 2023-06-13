// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  final int id;
  final String savedName;
  final String name;
  final String lat;
  final String long;
  final DateTime date;
  LocationModel({
    required this.id,
    required this.savedName,
    required this.date,
    required this.name,
    required this.lat,
    required this.long,
  });

  LocationModel copyWith({
    int? id,
    String? name,
    String? lat,
    String? long,
    DateTime? date,
    String? savedName
  }) {
    return LocationModel(
      id: id ?? this.id,
      savedName: savedName ?? this.savedName,
      name: name ?? this.name,
      lat:  lat ?? this.lat,
      long: long ?? this.long,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'savedName' : savedName,
      'name': name,
      'lat': lat,
      'long': long,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as int,
      savedName: map['savedName'] as String,
      name: map['name'] as String,
      lat: (map['lat'] as int).toString(),
      long: (map['long'] as int).toString(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LocationModel(name: $name, lat: $lat, long: $long, date: $date, savedName : $savedName), id : $id';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.lat == lat &&
        other.long == long && other.date == date && other.savedName == savedName && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ lat.hashCode ^ long.hashCode ^ date.hashCode ^ savedName.hashCode   ^ id.hashCode;
}
