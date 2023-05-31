
enum RouteSegmentType { walking, bus, train, tram }

class RouteSearchResultModel {
  final Duration departure;
  final List<Transport> transports;
  final Duration totalDuration;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final Duration walkingTime;

  const RouteSearchResultModel({
    required this.departure,
    required this.transports,
    required this.totalDuration,
    required this.departureTime,
    required this.arrivalTime,
    required this.walkingTime,
  });
}

// A helper class to represent a transport mode and its route number
class Transport {
  final RouteSegmentType segment;
  final String routeNumber;

  const Transport(this.segment, this.routeNumber);
}
