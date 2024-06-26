import 'package:app_settings/app_settings.dart';
import 'package:bus_navigation/features/routes/bloc/routes_bloc.dart';
import 'package:bus_navigation/features/routes/models/recent_route.dart';
import 'package:bus_navigation/features/save_locations/presentation/screen/saved_locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:latlong2/latlong.dart';
import 'screen_arguments_routes_args.dart';
import 'choose_from_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class SearchPage extends StatefulWidget {
  
  static const String route = "/SearchRoute";
  final ScreenArgumentsRoutesArgs screenArguments;
  const SearchPage({super.key, required this.screenArguments});

  @override
  State<SearchPage> createState() =>
      _SearchWidget(screenArguments: screenArguments);
}

class _SearchWidget extends State<SearchPage> {
  final ScreenArgumentsRoutesArgs screenArguments;
  TextEditingController controller = TextEditingController();

  _SearchWidget({required this.screenArguments});
  final String? api_key = dotenv.env['API_KEY'];
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  List<RecentRouteModel> recent_route = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesBloc, RoutesState>(builder: (context, state) {
      recent_route = state.routes;
      print(state);
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GooglePlaceAutoCompleteTextField(
                      textEditingController: controller,
                      googleAPIKey: api_key!,
                      inputDecoration: InputDecoration(
                        hintText: 'Location',
                        suffixIcon: IconButton(
                          // onPressed: .clear,
                          onPressed: () {
                            controller.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      debounceTime: 800, // default 600 ms,
                      countries: const [
                        'et'
                      ], // optional by default null is set
                      isLatLngRequired:
                          true, // if you required coordinates from place detail
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        // this method will return latlng with place detail
                        screenArguments.func(
                            LatLng(double.parse(prediction.lat.toString()),
                                double.parse(prediction.lng.toString())),
                            prediction.description);
                      }, // this callback is called when isLatLngRequired is true
                      itmClick: (Prediction prediction) {
                        controller.text = prediction.description!;
                        controller.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: prediction.description!.length));
                        Navigator.pop(context);
                      }),
                ),
                
                const Divider(
                  thickness: 0.3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed(MapPage.route,
                                arguments: screenArguments);
                          },
                          icon: Icon(Icons.map,
                              color: Colors.grey[700]), // lighter icon color
                          label: Text('Select on Map',
                              style: TextStyle(
                                  color:
                                      Colors.grey[700])), // lighter text color
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.lightBlue.withOpacity(0.1),
                              shadowColor: Colors.lightBlue.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                    color: Colors.lightBlue.withOpacity(0.2),
                                  ))), // lighter border color with radius 40
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            bool isLocationEnabled =
                              await Geolocator.isLocationServiceEnabled();
                          if (!isLocationEnabled) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Enable Location Services"),
                                  content: const Text(
                                      'Please enable location services.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Settings'),
                                      onPressed: () {
                                        AppSettings.openLocationSettings();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }
                          final Position val = await _determinePosition();
                            screenArguments.func(
                                LatLng(val.latitude, val.longitude),
                                'Your Current Location');
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.my_location,
                              color: Colors.grey[700]), // lighter icon color
                          label: Text('Use Your Location',
                              style: TextStyle(
                                  color:
                                      Colors.grey[700])), // lighter text color
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.lightBlue.withOpacity(0.1),
                              shadowColor: Colors.lightBlue.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                    color: Colors.lightBlue.withOpacity(0.2),
                                  ))), // lighter border color with radius 40
                        ),
                      ),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.recent_actors_outlined, color: Colors.black,)),
                        Tab(icon: Icon(Icons.directions_transit, color: Colors.black,)),
                      ],
                    ),
                  )
                ]),
                Expanded(
                  child: TabBarView(
                    children: [
                      Expanded(
                        child: state is RoutesLoading
                            ? const Text("Loading")
                            : ListView.separated(
                                itemCount: recent_route.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(
                                            color: Colors.grey[
                                                300]), // lighter divider color
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      screenArguments.func(
                                          LatLng(
                                              double.parse(
                                                  recent_route[index].lat),
                                              double.parse(
                                                  recent_route[index].long)),
                                          recent_route[index].name);
                                      Navigator.pop(context);
                                    },
                                    leading: const Icon(Icons
                                        .location_on_outlined), // location pin icon
                                    title: Text(recent_route[index]
                                        .name), // title of the suggestion
                                    subtitle: Text(recent_route[index]
                                        .date
                                        .toString()), // subtitle of the suggestion
                                    trailing: const Icon(Icons
                                        .copy), // copy icon at the most left side of the row
                                  );
                                },
                              ),
                      )
                      ,
                      ListLocations(screenArguments: screenArguments,),
                    ],
                  ),
                ),
                // Expanded(
                //   child: state is RoutesLoading
                //       ? const Text("Loading")
                //       : ListView.separated(
                //           itemCount: recent_route.length,
                //           separatorBuilder: (BuildContext context, int index) =>
                //               Divider(
                //                   color: Colors
                //                       .grey[300]), // lighter divider color
                //           itemBuilder: (BuildContext context, int index) {
                //             return ListTile(
                //               onTap: () {
                //                 screenArguments.func(
                //                     LatLng(
                //                         double.parse(recent_route[index].lat),
                //                         double.parse(recent_route[index].long)),
                //                     recent_route[index].name);
                //                 Navigator.pop(context);
                //               },
                //               leading: const Icon(Icons
                //                   .location_on_outlined), // location pin icon
                //               title: Text(recent_route[index]
                //                   .name), // title of the suggestion
                //               subtitle: Text(recent_route[index]
                //                   .date
                //                   .toString()), // subtitle of the suggestion
                //               trailing: const Icon(Icons
                //                   .copy), // copy icon at the most left side of the row
                //             );
                //           },
                //         ),
                // )
              ],
            ),
          ),
        ),
      );
    });
  }
}
