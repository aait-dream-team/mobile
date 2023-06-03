// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bus_navigation/core/local_db/local_db.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart' ;


class RecentRouteDataProvider {
  static LocalDB db = LocalDB.instance;

  Future<List<RecentRouteModel>> getAllRoutes() async {
    var data = await db.getRecentRoutes();
    return data;
    // return [];
  }

  Future<void> addRoute(RecentRouteModel route) async {
    print(route);
    await db.insertRecentRoute(route.toMap());
  }

  Future<void> addRoutes(List<RecentRouteModel> routes) async {
    for (var i = 0; i < routes.length; i++) {
      await addRoute(routes[i]);
    }
  }

}
