import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/save_locations/model/pin_location.dart';
import 'package:bus_navigation/features/save_locations/presentation/screen/saved_locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:another_flushbar/flushbar.dart';
import '../../bloc/locations_bloc.dart';

class SavedLocations extends StatefulWidget {
  static const String route = "/routes";
  final PinPoint location;
  const SavedLocations({super.key, required this.location});

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
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)),
                          )),
                          GestureDetector(
                            onTap: () {
                              if (locationController.text == '') {
                                Flushbar(
                                  title: "Error",
                                  message: "Label can not be empty",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                                return;
                              }
                              context.read<LocationsBloc>().add(SaveLocation(
                                  name: locationController.text,
                                  location: widget.location));
                              locationController.clear();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: const InkWell(
                                  child: Text(
                                'Save Location',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
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
