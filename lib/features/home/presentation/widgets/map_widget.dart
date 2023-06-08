import 'package:bus_navigation/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

import '../../../routes/bloc/routes_bloc.dart';
import '../../../routes/models/pin.dart';
import '../../../routes/presentation/screens/routes_page.dart';
import '../../../routes/presentation/screens/screen_arguments_routes.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget>
    with AutomaticKeepAliveClientMixin<MapWidget> {
  Future<String> getNameFromLatLng(LatLng latlng) async {
    print(latlng);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    Placemark place = placemarks[0];
    String locationName =
        "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode} ${place.country}";
    print(locationName);
    return locationName;
  }

  final txt = Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 30),
    child: ClipRRect(
      child: Expanded(
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
            )),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                  child: Text(
                'Apply Coupon',
                style: TextStyle(color: Colors.white),
              )),
            )
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      // TODO: implement listener
      if (state is HomePinnedState) {
        final details = state.name.split(',');
        final name = details[0];
        final street = details[1];
        final sub_city = details[2];
        final city = details[3];

        showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.001),
                  child: GestureDetector(
                    onTap: () {},
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.4,
                      minChildSize: 0.2,
                      maxChildSize: 0.75,
                      builder: (_, controller) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: controller,
                                  itemCount: 1,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Card(
                                        elevation: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            SizedBox(height: 16),
                                            ListTile(
                                              title: Text(name),
                                              isThreeLine: true,
                                              subtitle: Text(
                                                  '${street}\n${sub_city}'),
                                              trailing: Text(city),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0),
                                              height: 40.0,
                                              child: Expanded(
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      onPressed: () async {
                                                        BlocProvider.of<
                                                                    RoutesBloc>(
                                                                context)
                                                            .add(PointPicked(
                                                                from: PinPoint(
                                                                    name: state
                                                                        .name,
                                                                    location: state
                                                                        .pinPosition),
                                                                to: PinPoint(
                                                                    name: '',
                                                                    location: state
                                                                        .pinPosition)));
                                                        Navigator.pushNamed(
                                                            context,
                                                            RoutesPage.route,
                                                            arguments: ScreenArgumentsRoutes(
                                                                type: 'from',
                                                                name:
                                                                    state.name,
                                                                location: state
                                                                    .pinPosition));
                                                      },
                                                      icon: Icon(Icons.home),
                                                      label: Text(
                                                          'Set Destination'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        onPrimary:
                                                            Color.fromARGB(255,
                                                                4, 133, 239),
                                                        side: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    133,
                                                                    239)),
                                                      ),
                                                    ),
                                                    SizedBox(width: 16),
                                                    ElevatedButton.icon(
                                                      onPressed: () async {
                                                        Navigator.pushNamed(
                                                            context,
                                                            RoutesPage.route,
                                                            arguments: ScreenArgumentsRoutes(
                                                                type: 'to',
                                                                name:
                                                                    state.name,
                                                                location: state
                                                                    .pinPosition));
                                                      },
                                                      icon: Icon(Icons.home),
                                                      label:
                                                          Text('Set Arrival'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        onPrimary:
                                                            Color.fromARGB(255,
                                                                4, 133, 239),
                                                        side: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    133,
                                                                    239)),
                                                      ),
                                                    ),
                                                    SizedBox(width: 16),
                                                    ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.home),
                                                      label: Text('Button 1'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        onPrimary:
                                                            Color.fromARGB(255,
                                                                4, 133, 239),
                                                        side: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    133,
                                                                    239)),
                                                      ),
                                                    ),
                                                    SizedBox(width: 16),
                                                    ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.home),
                                                      label: Text('Button 1'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        onPrimary:
                                                            Color.fromARGB(255,
                                                                4, 133, 239),
                                                        side: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    133,
                                                                    239)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 16),
                              
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  height: 50,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 0),
                                                  child: ClipRRect(
                                                    child: Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            10)),
                                                          )),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .redAccent,
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          50),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          50)),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            child: InkWell(
                                                                child: Text(
                                                              'Add Label',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    }, builder: (context, state) {
      return FlutterMap(
        options: MapOptions(
            center: state.position,
            zoom: state.zoom,
            maxZoom: 17.0,
            interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            onPositionChanged: ((position, hasGesture) async {
              if (state is HomePinnedState) {
                context.read<HomeBloc>().add(MapPinChanged(
                    position: state.position,
                    zoom: state.zoom,
                    name: await getNameFromLatLng(state.pinPosition),
                    pinPosition: state.pinPosition));
              } else {
                context.read<HomeBloc>().add(
                    MapMoved(position: position.center!, zoom: position.zoom!));
              }
            }),
            onTap: (tapPos, latlng) async {
              context.read<HomeBloc>().add(MapPinChanged(
                  position: state.position,
                  zoom: state.zoom,
                  name: await getNameFromLatLng(latlng),
                  pinPosition: latlng));
            }),
        nonRotatedChildren: [
          // if (state is HomePinnedState)
          //   Align(
          //     // use the Align widget to position the card
          //     alignment:
          //         Alignment.bottomCenter, // set the alignment to bottom center
          //     child: Card(
          //       elevation: 10.0, // the elevation of the card
          //       shadowColor: Colors.grey, // the color of the shadow
          //       shape: RoundedRectangleBorder(
          //         // the shape of the card
          //         borderRadius: BorderRadius.circular(25.0), // rounded corners
          //       ),
          //       child: Padding(
          //         // add some padding to the card content
          //         padding: const EdgeInsets.all(16.0),
          //         child: Column(
          //           // arrange the text and buttons in a column
          //           mainAxisSize: MainAxisSize
          //               .min, // shrink the column to fit the content
          //           crossAxisAlignment: CrossAxisAlignment
          //               .start, // align the content to the start
          //           children: [
          //             Text("${state.name}"), // display the text
          //             const SizedBox(height: 16.0), // add some vertical space
          //             Row(
          //               // arrange the buttons in a row
          //               mainAxisAlignment: MainAxisAlignment
          //                   .end, // align the buttons to the end
          //               children: [
          //                 ElevatedButton(
          //                   // create the first option button
          //                   onPressed: () async {
          //                     BlocProvider.of<RoutesBloc>(context).add(
          //                         PointPicked(
          //                             from: PinPoint(
          //                                 name: state.name,
          //                                 location: state.pinPosition),
          //                             to: PinPoint(
          //                                 name: '',
          //                                 location: state.pinPosition)));
          //                     Navigator.pushNamed(context, RoutesPage.route,
          //                         arguments: ScreenArgumentsRoutes(
          //                             type: 'from',
          //                             name: state.name,
          //                             location: state.pinPosition));
          //                   }, // call the callback function when pressed
          //                   child: const Text(
          //                       'Set Destination'), // display the button label
          //                 ),
          //                 const SizedBox(
          //                     width: 8.0), // add some horizontal space
          //                 ElevatedButton(
          //                   // create the second option button
          //                   onPressed: () async {
          //                     Navigator.pushNamed(context, RoutesPage.route,
          //                         arguments: ScreenArgumentsRoutes(
          //                             type: 'to',
          //                             name: state.name,
          //                             location: state.pinPosition));
          //                   }, // call the callback function when pressed
          //                   child: const Text(
          //                       'Set Arrival'), // display the button label
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   )
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
