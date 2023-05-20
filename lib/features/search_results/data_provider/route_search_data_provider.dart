
import '../models/RouteResultModel.dart';

class RouteSearchDataProvider {
  Future<List<RouteSearchResultModel>> getSearchResults() async {
    return Future.delayed(
        const Duration(seconds: 1),
        () => [
              RouteSearchResultModel(
                  departureInMinutes: 15,
                  transports: [
                    const Transport(RouteSegmentType.train, "S1"),
                    const Transport(RouteSegmentType.tram, "U6"),
                  ],
                  totalDuration: 45,
                  departureTime: DateTime(2023, 4, 24, 19, 30),
                  arrivalTime: DateTime(2023, 4, 24, 20, 15),
                  walkingTime: 10),
              RouteSearchResultModel(
                  departureInMinutes: 15,
                  transports: [
                    const Transport(RouteSegmentType.train, "S1"),
                    const Transport(RouteSegmentType.tram, "U6"),
                    const Transport(RouteSegmentType.bus, "72"),
                  ],
                  totalDuration: 45,
                  departureTime: DateTime(2023, 4, 24, 19, 30),
                  arrivalTime: DateTime(2023, 4, 24, 20, 15),
                  walkingTime: 10),
              RouteSearchResultModel(
                  departureInMinutes: 15,
                  transports: [
                    const Transport(RouteSegmentType.train, "S1"),
                    const Transport(RouteSegmentType.tram, "U6"),
                    const Transport(RouteSegmentType.bus, "72"),
                    const Transport(RouteSegmentType.tram, "U1"),
                    const Transport(RouteSegmentType.bus, "42"),
                  ],
                  totalDuration: 45,
                  departureTime: DateTime(2023, 4, 24, 19, 30),
                  arrivalTime: DateTime(2023, 4, 24, 20, 15),
                  walkingTime: 10),
              RouteSearchResultModel(
                  departureInMinutes: 15,
                  transports: [
                    const Transport(RouteSegmentType.bus, "72"),
                  ],
                  totalDuration: 45,
                  departureTime: DateTime(2023, 4, 24, 9, 30),
                  arrivalTime: DateTime(2023, 4, 24, 10, 15),
                  walkingTime: 10),
            ]);
  }
}
