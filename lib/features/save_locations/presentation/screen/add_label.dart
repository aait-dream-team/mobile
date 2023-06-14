import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/save_locations/model/pin_location.dart';
import 'package:bus_navigation/features/save_locations/presentation/screen/saved_locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../bloc/locations_bloc.dart';

class SavedLocations extends StatefulWidget {
  static const String route = "/routes";
  const SavedLocations({super.key});

  @override
  State<SavedLocations> createState() => _SavedLocations();
}

class _SavedLocations extends State<SavedLocations> {
  _SavedLocations();
  List<PinLocation> items = [];
  TextEditingController locationController = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        if (state is FetchSavedLocations) {
          items = state.locations;
        }
        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    child: Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)),
                          )),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                                onTap: () {
                                  print(locationController.text);
                                  context.read<LocationsBloc>().add(
                                      SaveLocation(
                                          name: locationController.text,
                                          location: PinPoint(
                                              name: "name",
                                              location: LatLng(0.0, 0.0))));
                                  locationController.clear();
                                },
                                child: Text(
                                  'Save Location',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
            ListLocations()
          ],
        );
      },
    );
  }
}
