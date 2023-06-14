import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';

import '../../nav_detail/model/nav_detail_model.dart';
import '../models/RouteResultModel.dart';

class RouteSearchDataProvider {
  Future<List<(RouteSearchResultModel, NavDetailModel)>> getSearchResults(
      LatLng from,
      LatLng to,
      DateTime departureDate,
      bool isDepartureTime) async {
    var data = await getApiContent(from, to, departureDate, isDepartureTime);
    var details = getItineraries(data)
        .cast<Map<String, dynamic>>()
        .map(NavDetailModel.fromMap)
        .toList();
    var routes = getRoutes(data);
    List<(RouteSearchResultModel, NavDetailModel)> results = [];
    for (int i = 0; i < routes.length; i++) {
      results.add((routes[i], details[i]));
    }
    return results;
  }

  List<RouteSearchResultModel> getRoutes(dynamic data) {
    List<dynamic> itineraries = getItineraries(data);
    return itineraries
        .map(convertToRoute)
        .whereType<RouteSearchResultModel>()
        .toList();
  }

  List<dynamic> getItineraries(dynamic data) {
    if (data is Map) {
      var plan = data["plan"];
      if (plan is Map) {
        var itineraries = plan["itineraries"];
        if (itineraries is List) {
          return itineraries;
        }
      }
    }
    return [];
  }

  RouteSearchResultModel? convertToRoute(dynamic data) {
    if (data is Map) {
      var totalDuration = Duration(seconds: data["duration"]);
      var walkingTime = Duration(seconds: data["walkTime"]);
      var arrivalTime = DateTime.fromMillisecondsSinceEpoch(data["endTime"]);
      var departureTime =
          DateTime.fromMillisecondsSinceEpoch(data["startTime"]);
      var departure = departureTime.difference(DateTime.now());
      var legs = data["legs"];
      if (legs is List) {
        var transports = legs
            .map((leg) {
              if (leg["mode"] == "WALK") {
                return null;
              }
              if (leg["mode"] == "BUS") {
                return Transport(RouteSegmentType.bus, leg["routeShortName"]);
              }
            })
            .whereType<Transport>()
            .toList();
        return RouteSearchResultModel(
            departure: departure,
            transports: transports,
            totalDuration: totalDuration,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            walkingTime: walkingTime);
      }
    }
    return null;
  }

  Future<dynamic> getApiContent(LatLng from, LatLng to, DateTime departureDate,
      bool isDepartureTime) async {
    departureDate = (DateTime.now().isAfter(departureDate))
        ? DateTime.now().add(const Duration(minutes: 1))
        : departureDate;

    var URL =
        "http://34.125.99.126:8082/otp/routers/default/plan?fromPlace=${from.latitude},${from.longitude}&toPlace=${to.latitude},${to.longitude}&time=${DateFormat('hh:mm a').format(departureDate)}&date=${DateFormat('MM-dd-yyyy').format(departureDate)}&mode=TRANSIT%2CWALK&wheelchair=false&showIntermediateStops=true&debugItineraryFilter=false&locale=en&numItineraries=10&arriveBy=${!isDepartureTime}";

    var response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      // parse the response body as JSON
      var data = jsonDecode(response.body);
      // print(data["plan"]["itineraries"][0]["legs"][1]["mode"]);
      for (var iti in data["plan"]["itineraries"]) {
        for (var legs in iti["legs"]) {
          if (legs["mode"] != "WALK") {
            print(legs["agencyId"]);
          }
        }
      }
      print('before');

      return data;
    } else {
      // handle the error
      return null;
    }
  }
}
