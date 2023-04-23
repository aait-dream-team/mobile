// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bus_navigation/features/history/data_provider/mock_data.dart';
import 'package:bus_navigation/features/history/models/RouteHistory.dart';

class RouteHistoryDataProvider {
  Future<Map<DateTime, List<RouteModel>>> getAllRoutes() async {
    await Future.delayed(const Duration(seconds: 5));

    return mockdata;
  }
}
