import 'package:bus_navigation/features/routes/data_provider/recent_route_data_provider.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';

class RecentRouteRepository {
  final RecentRouteDataProvider dataProvider;

  RecentRouteRepository({
    required this.dataProvider,
  });

  Future<List<RecentRouteModel>> getAllRoutes() async {
    final data =  await dataProvider.getAllRecentRoutes();
    return data;
  }

  Future<void> addRecentRoute(RecentRouteModel recent_route) async {
    await dataProvider.addRoute(recent_route);
  }
}
