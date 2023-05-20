
enum RouteSegmentType { walking, bus, train, tram }

class RouteSearchResultModel {
  final int departureInMinutes;
  final List<Transport> transports;
  final int totalDuration;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int walkingTime;

  const RouteSearchResultModel({
    required this.departureInMinutes,
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
