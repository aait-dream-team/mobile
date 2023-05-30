import 'package:latlong2/latlong.dart';

import '../data_provider/route_search_data_provider.dart';
import '../models/RouteResultModel.dart';

class RouteSearchRepository {
  final RouteSearchDataProvider dataProvider;

  RouteSearchRepository({
    required this.dataProvider,
  });

  Future<List<RouteSearchResultModel>> getSearchResults(LatLng from, LatLng to, DateTime departureDate) async {
    return await dataProvider.getSearchResults(from, to, departureDate);
  }
}
