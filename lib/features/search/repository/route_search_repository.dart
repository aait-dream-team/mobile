import 'package:bus_navigation/features/search/data_provider/route_search_data_provider.dart';
import 'package:bus_navigation/features/search/models/RouteResultModel.dart';

class RouteSearchRepository {
  final RouteSearchDataProvider dataProvider;

  RouteSearchRepository({
    required this.dataProvider,
  });

  Future<List<RouteSearchResultModel>> getSearchResults() async {
    return await dataProvider.getSearchResults();
  }
}
