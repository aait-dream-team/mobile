import 'package:bus_navigation/features/navigate/data_provider/navigation_data_provider.dart';
import 'package:latlong2/latlong.dart';

class NavigationRepository {
  final NavigationDataProvider dataProvider;

  NavigationRepository({
    required this.dataProvider,
  });

  Future<List<List<LatLng>>> getRouteDetails() async {
    return await dataProvider.getRouteDetails();
  }
}
