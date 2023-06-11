import '../data_provider/route_history_data_provider.dart';
import '../models/RouteHistory.dart';

class RouteHistoryRepository {
  final RouteHistoryDataProvider dataProvider;
  RouteHistoryRepository({
    required this.dataProvider,
  });

  Future<Map<DateTime, List<RouteModel>>> getAllRoutes() async {
    return await dataProvider.getAllRoutes();
  }

  Future<void> addRoute(RouteModel route) async {
    await dataProvider.addRoute(route);
  }
}
