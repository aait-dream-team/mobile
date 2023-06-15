import 'package:bus_navigation/features/routes/bloc/routes_bloc.dart';
import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/routes/presentation/screens/routes_page.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes_args.dart';
import 'package:bus_navigation/features/save_locations/model/pin_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../bloc/locations_bloc.dart';

class ListLocations extends StatefulWidget {
  static const String route = "/routes";
  final ScreenArgumentsRoutesArgs? screenArguments;

  const ListLocations({super.key, this.screenArguments});
  // final bool isHome;

  @override
  State<ListLocations> createState() => _ListLocations();
}

class _ListLocations extends State<ListLocations> {
  _ListLocations();
  List<PinLocation> items = [];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        if (state is FetchSavedLocations) {
          items = state.locations;
        }
        return Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Dismissible(
                key: Key(item.name),
                onDismissed: (direction) {
                  context
                      .read<LocationsBloc>()
                      .add(DeleteLocation(id: item.id));
                  setState(() {
                    items.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item.name} dismissed")));
                },
                background: Container(color: Colors.red[300]),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.save_as_rounded),
                    ),
                    onTap: () {
                      if (widget.screenArguments == null) {
                        BlocProvider.of<RoutesBloc>(context).add(PointPicked(
                            from: PinPoint(
                                name: item.location.name,
                                location: item.location.location),
                            to: PinPoint(name: '', location: LatLng(0, 0)),
                            datetime: DateTime.now(),
                            isDepartureTime: true));
                        Navigator.pushNamed(context, RoutesPage.route,
                            arguments: ScreenArgumentsRoutes(
                              type: 'from',
                              name: item.location.name,
                              location: item.location.location,
                            ));
                      } else {
                        widget.screenArguments!
                            .func(item.location.location, item.location.name);
                        Navigator.pop(context);
                      }
                    },
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    subtitle: Text(item.location.name
                        .substring(0, item.location.name.indexOf(','))),
                    trailing: Text(
                      DateFormat.MMMd().format(item.date),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32))),
                    selectedTileColor: Colors.orange[100],
                    selected: false,
                    // onTap: () {},
                    // leading: Icon(icon),
                    // title: Text(title),
                  ),
                ),
              );
            },
          ),
        ));
      },
    );
  }
}
