import 'package:bus_navigation/features/routes/data_provider/recent_route_data_provider.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';

class RecentRouteRepository {
  final RecentRouteDataProvider dataProvider;

  RecentRouteRepository({
    required this.dataProvider,
  });

  Future<List<RecentRouteModel>> getAllRoutes() async {
    final data = await dataProvider.getAllRecentRoutes();
    return getUniqueRoutes(data);
  }

  Future<void> addRecentRoute(RecentRouteModel recentRoute) async {
    await dataProvider.addRoute(recentRoute);
  }

  List<RecentRouteModel> getUniqueRoutes(List<RecentRouteModel> routes) {
    List<RecentRouteModel> uniqueRoutes = [];
    Set<String> names = {};
    for (RecentRouteModel route in routes) {
      if (!names.contains(route.name)) {
        uniqueRoutes.add(route);
        names.add(route.name);
      }
    }
    return uniqueRoutes;
  }
}
