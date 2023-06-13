import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:bus_navigation/features/navigate/repository/navigation_repository.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:turf/turf.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final NavigationRepository repository;

  NavigationBloc({required this.repository}) : super(NavigationInitialState()) {
    on<NavigationEvent>((event, emit) async {
      if (event is LoadNavigationEvent) {
        emit(NavigationLoadingState());

        final value = parsePoints(event.polylineString);
        emit(NavigationSuccessState(
            routePoints: value, navDetailModel: event.navDetailModel));
      } else if (event is StartNavigationEvent) {
        if (state is NavigationSuccessState) {
          var legs = (state as NavigationSuccessState).routePoints;
          var navDetailModel = (state as NavigationSuccessState).navDetailModel;
          emit(NavigationRoutingState(
              legs: legs,
              currentIndex: 0,
              currentInnerIndex: 0,
              userPointInRoute: legs[0][0],
              userLocation: legs[0][0],
              navDetailModel: navDetailModel,
              currentIntermidateStopIndex: 0));
        }
      } else if (event is UpdateUserLocationEvent) {
        if (state is NavigationRoutingState) {
          var legs = (state as NavigationRoutingState).legs;
          var update = findNearestPoint(event.location, legs);
          var innerInd = legs[update.$1].indexOf(update.$2);
          if (innerInd == -1) {
            innerInd = (state as NavigationRoutingState).currentInnerIndex;
          }
          var navDetailModel = (state as NavigationRoutingState).navDetailModel;
          int currentIndex = update.$1;
          int currentIntermidateStopInd =
              (state as NavigationRoutingState).currentIntermidateStopIndex;
          if (navDetailModel.legs[currentIndex].intermidateStops != null) {
            currentIntermidateStopInd = findNearestIntermidateStop(
                event.location,
                navDetailModel.legs[currentIndex].intermidateStops!
                    .map((e) => e.location)
                    .toList());
          }
          emit(NavigationRoutingState(
              legs: legs,
              currentIndex: update.$1,
              currentInnerIndex: innerInd,
              userPointInRoute: update.$2,
              userLocation: event.location,
              navDetailModel: navDetailModel,
              currentIntermidateStopIndex: currentIntermidateStopInd));
        }
      } else if (event is CancelNavigationEvent) {
        if (state is NavigationRoutingState) {
          emit(NavigationSuccessState(
              routePoints: (state as NavigationRoutingState).legs,
              navDetailModel:
                  (state as NavigationRoutingState).navDetailModel));
        }
      }
    });
  }

  static List<List<LatLng>> parsePoints(List<String> polylineStrings) {
    PolylinePoints polylinePoints = PolylinePoints();

    return polylineStrings
        .map((e) => polylinePoints
            .decodePolyline(e)
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList())
        .toList();
  }

  // A function that takes a user location and a list of polylines and returns the index of the polyline and the nearest point on it
  (int, LatLng) findNearestPoint(
      LatLng userLocation, List<List<LatLng>> polylines) {
    // Convert the user location to a Point object
    Point userPoint = Point(
        coordinates: Position(
      userLocation.longitude,
      userLocation.latitude,
    ));

    // Initialize a variable to store the minimum distance and the corresponding index and point
    double minDistance = double.infinity;
    int minIndex = -1;
    LatLng minPoint = polylines[0][0];

    // Loop through the list of polylines
    for (int i = 0; i < polylines.length; i++) {
      // Convert each polyline to a LineString object
      LineString line = LineString(
          coordinates: polylines[i]
              .map((latlng) => Position(
                    latlng.longitude,
                    latlng.latitude,
                  ))
              .toList());

      // Find the nearest point on the line using the nearestPointOnLine function
      Feature<Point> nearestPoint = nearestPointOnLine(line, userPoint);
      // Calculate the distance between the user point and the nearest point using the distance function
      double distance =
          (nearestPoint.properties?["dist"] ?? double.infinity) as double;

      // Update the minimum distance and the corresponding index and point if needed
      if (distance < minDistance) {
        minDistance = distance;
        minIndex = i;
        minPoint = LatLng(nearestPoint.geometry!.coordinates[1]! as double,
            nearestPoint.geometry!.coordinates[0]! as double);
      }
    }

    // Return the index of the polyline and the nearest point on it
    return (minIndex, minPoint);
  }

  int findNearestIntermidateStop(
      LatLng userLocation, List<LatLng> intermidateStops) {
    Feature<Point> nearestStop = nearestPoint(
        Feature(
            geometry: Point(
                coordinates:
                    Position(userLocation.longitude, userLocation.latitude))),
        FeatureCollection(
            features: intermidateStops
                .map((e) => Feature(
                    geometry:
                        Point(coordinates: Position(e.longitude, e.latitude))))
                .toList()));
    return intermidateStops.indexWhere((element) =>
        element.latitude == (nearestStop.geometry!.coordinates[1]! as double) &&
        element.longitude == (nearestStop.geometry!.coordinates[0] as double));
  }
}
