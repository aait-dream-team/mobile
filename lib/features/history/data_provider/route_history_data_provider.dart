// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bus_navigation/core/local_db/local_db.dart';
import 'package:bus_navigation/features/history/models/RouteHistory.dart';

class RouteHistoryDataProvider {
  static LocalDB db = LocalDB.instance;

  Future<Map<DateTime, List<RouteModel>>> getAllRoutes() async {
    var data = await db.getRoutes();

    return _convertRoute(data);
  }

  Future<void> addRoute(RouteModel route) async {
    await db.insertRoute(route.toMap());
  }

  Future<void> addRoutes(List<RouteModel> routes) async {
    for (var i = 0; i < routes.length; i++) {
      await addRoute(routes[i]);
    }
  }

  Future<Map<DateTime, List<RouteModel>>> _convertRoute(data) async {
    Map<DateTime, List<RouteModel>> result = {};

    data.forEach((element) {
      var item = RouteModel.fromMap(element);
      if (result.containsKey(item.date)) {
        result[item.date]!.add(item);
      } else {
        result[item.date] = [item];
      }
    });
    return result;
  }
}
