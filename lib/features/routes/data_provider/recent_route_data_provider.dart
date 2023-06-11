// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bus_navigation/core/local_db/local_db.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';

class RecentRouteDataProvider {
  static LocalDB db = LocalDB.instance;

  Future<List<RecentRouteModel>> getAllRecentRoutes() async {
    var data = await db.getRecentRoutes();
    return await _convertRoute(data);
  }

  Future<void> addRoute(RecentRouteModel route) async {
    await db.insertRecentRoute(route.toMap());
  }

  Future<void> addRecentRoutes(List<RecentRouteModel> routes) async {
    for (var i = 0; i < routes.length; i++) {
      await addRoute(routes[i]);
    }
  }

  Future<List<RecentRouteModel>> _convertRoute(data) async {
    List<RecentRouteModel> result = [];

    data.forEach((element) {
      var item = RecentRouteModel.fromMap(element);
      result.add(item);
    });
    return result;
  }
}
