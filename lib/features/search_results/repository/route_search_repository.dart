import 'package:latlong2/latlong.dart';

import '../../nav_detail/model/nav_detail_model.dart';
import '../data_provider/route_search_data_provider.dart';
import '../models/RouteResultModel.dart';

class RouteSearchRepository {
  final RouteSearchDataProvider dataProvider;

  RouteSearchRepository({
    required this.dataProvider,
  });

  Future<List<(RouteSearchResultModel, NavDetailModel)>> getSearchResults(
      LatLng from, LatLng to, DateTime departureDate, bool isDepartureTime) async {
    return await dataProvider.getSearchResults(from, to, departureDate, isDepartureTime);
  }
  
}
