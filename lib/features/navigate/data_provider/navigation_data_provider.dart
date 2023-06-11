import 'dart:convert';
import 'package:bus_navigation/features/navigate/data_provider/sample_response.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:latlong2/latlong.dart';

class NavigationDataProvider {
  Future<List<List<LatLng>>> getRouteDetails() async {
    var data = await getJsonContents();
    var routeLegs = getRouteLegs(data);
    var points = routeLegs.map((e) => e["legGeometry"]["points"]);
    PolylinePoints polylinePoints = PolylinePoints();

    // Decode the string and create a list of LatLng objects
    List<List<LatLng>> latLngList = points
        .map((geo) => polylinePoints
            .decodePolyline(geo)
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList())
        .toList();
    return latLngList;
  }

  List<dynamic> getRouteLegs(dynamic data) {
    if (data is Map) {
      var route = data["plan"];
      if (route is Map) {
        var itineraries = route["itineraries"];
        if (itineraries is List) {
          var itin = itineraries[0];
          if (itin is Map) {
            var legs = itin["legs"];
            if (legs is List) {
              return legs;
            }
          }
        }
      }
    }
    return [];
  }

  Future<dynamic> getJsonContents() async {
    var contents = response;
    // Decode the string to a JSON object
    return jsonDecode(contents);
  }
}
