import 'package:bus_navigation/features/home/bloc/home_bloc.dart';
import 'package:bus_navigation/features/home/presentation/widgets/screen_argumnets_home.dart';
import 'package:bus_navigation/features/routes/bloc/routes_bloc.dart';
import 'package:bus_navigation/features/routes/model/pin.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:bus_navigation/features/routes/presentation/screens/routes_page.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget>
    with AutomaticKeepAliveClientMixin<MapWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return FlutterMap(
        options: MapOptions(
            center: state.position,
            zoom: state.zoom,
            maxZoom: 17.0,
            interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            onPositionChanged: ((position, hasGesture) {
              if (state is HomePinnedState) {
                context.read<HomeBloc>().add(MapPinChanged(
                    position: state.position,
                    zoom: state.zoom,
                    pinPosition: state.pinPosition));
              } else {
                context.read<HomeBloc>().add(
                    MapMoved(position: position.center!, zoom: position.zoom!));
              }
            }),
            onTap: (tapPos, latlng) {
              context.read<HomeBloc>().add(MapPinChanged(
                  position: state.position,
                  zoom: state.zoom,
                  pinPosition: latlng));
            }),
        nonRotatedChildren: [
          if (state is HomePinnedState)
            Align(
              // use the Align widget to position the card
              alignment:
                  Alignment.bottomCenter, // set the alignment to bottom center
              child: Card(
                elevation: 10.0, // the elevation of the card
                shadowColor: Colors.grey, // the color of the shadow
                shape: RoundedRectangleBorder(
                  // the shape of the card
                  borderRadius: BorderRadius.circular(25.0), // rounded corners
                ),
                child: Padding(
                  // add some padding to the card content
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // arrange the text and buttons in a column
                    mainAxisSize: MainAxisSize
                        .min, // shrink the column to fit the content
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // align the content to the start
                    children: [
                      Text(
                          "${state.pinPosition.latitude}, ${state.pinPosition.longitude}"), // display the text
                      SizedBox(height: 16.0), // add some vertical space
                      Row(
                        // arrange the buttons in a row
                        mainAxisAlignment: MainAxisAlignment
                            .end, // align the buttons to the end
                        children: [
                          ElevatedButton(
                            // create the first option button
                            onPressed: () {
                              BlocProvider.of<RoutesBloc>(context).add(
                                  PointPicked(
                                      from: PinPoint(
                                          name: 'Pin Location',
                                          location: state.pinPosition),
                                      to: PinPoint(
                                          name: '',
                                          location: state.pinPosition)));
                              Navigator.pushNamed(context, RoutesPage.route,
                                  arguments: ScreenArgumentsRoutes(
                                      type: 'from',
                                      name: "Pin Location",
                                      location: state.pinPosition));
                            }, // call the callback function when pressed
                            child: Text(
                                'Set Destination'), // display the button label
                          ),
                          SizedBox(width: 8.0), // add some horizontal space
                          ElevatedButton(
                            // create the second option button
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesPage.route,
                                  arguments: ScreenArgumentsRoutes(
                                      type: 'to',
                                      name: "Pin Location",
                                      location: state.pinPosition));
                            }, // call the callback function when pressed
                            child:
                                Text('Set Arrival'), // display the button label
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
        children: [
          TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              tileProvider: FMTC.instance('mapStore').getTileProvider()),
          if (state is HomePinnedState)
            MarkerLayer(
              markers: [
                Marker(
                    point: state.pinPosition,
                    builder: (BuildContext context) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ))
              ],
            )
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
