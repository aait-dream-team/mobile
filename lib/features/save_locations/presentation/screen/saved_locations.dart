import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/save_locations/model/pin_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../bloc/locations_bloc.dart';

class ListLocations extends StatefulWidget {
  static const String route = "/routes";
  const ListLocations({super.key});

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
            child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return Dismissible(
              key: Key(item.name),
              onDismissed: (direction) {
                context.read<LocationsBloc>().add(DeleteLocation(id: item.id));
                setState(() {
                  items.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${item.name} dismissed")));
              },
              background: Container(color: Colors.red[300]),
              child: ListTile(
                title: Text('${item.name}'),
                subtitle: Text(item.location.name),
                trailing: Text(formatter.format(item.date)),
              ),
            );
          },
        ));
      },
    );
  }
}
