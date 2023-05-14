import 'package:bus_navigation/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

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
              context.read<HomeBloc>().add(
                  MapMoved(position: position.center!, zoom: position.zoom!));
            })),
        nonRotatedChildren: [],
        children: [
          TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              tileProvider: FMTC.instance('mapStore').getTileProvider()),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
