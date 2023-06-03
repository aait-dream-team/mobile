import 'package:bus_navigation/features/routes/models/pin.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes.dart';
import 'package:bus_navigation/features/search_results/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import './search_routes_page.dart';
import '../../bloc/routes_bloc.dart';
import 'screen_arguments_routes_args.dart';
import 'package:bus_navigation/features/search_results/presentation/screens/search_result_page.dart';

class RoutesPage extends StatefulWidget {
  static const String route = "/routes";
  final ScreenArgumentsRoutes? screenArgumentsRoutes;
  const RoutesPage({super.key, this.screenArgumentsRoutes});

  @override
  State<RoutesPage> createState() =>
      _RoutesWidget(screenArgumentsRoutes: screenArgumentsRoutes);
}

class _RoutesWidget extends State<RoutesPage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  ScreenArgumentsRoutes? screenArgumentsRoutes;

  _RoutesWidget({this.screenArgumentsRoutes});
  @override
  Widget build(BuildContext context) {
    // print(screenArgumentsRoutes);
    return BlocBuilder<RoutesBloc, RoutesState>(builder: (context, state) {
      if (screenArgumentsRoutes != null  ) {
        if (screenArgumentsRoutes!.type == 'from') {
          context.read<RoutesBloc>().add(PointPicked(
              from: PinPoint(
                  name: screenArgumentsRoutes!.name,
                  location: screenArgumentsRoutes!.location),
              to: state is RoutesPinPoint
                  ? state.to
                  : PinPoint(name: '', location: LatLng(0.0, 0.0))));
        } else {
          context.read<RoutesBloc>().add(PointPicked(
              to: PinPoint(
                  name: screenArgumentsRoutes!.name,
                  location: screenArgumentsRoutes!.location),
              from: state is RoutesPinPoint
                  ? state.from
                  : PinPoint(name: '', location: LatLng(0.0, 0.0))));
        }
        screenArgumentsRoutes = null;
      }

      if (state is RoutesPinPoint) {
        fromController.text = state.from.name;
        toController.text = state.to.name;
      }
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: fromController,
                readOnly: true,
                onTap: () => {
                  Navigator.of(context).pushNamed(SearchPage.route,
                      arguments: ScreenArgumentsRoutesArgs(
                          name: 'from ',
                          func: (LatLng loc, String name) {
                            final PinPoint from =
                                PinPoint(name: name, location: loc);
                            if (state is RoutesPinPoint) {
                              context
                                  .read<RoutesBloc>()
                                  .add(PointPicked(from: from, to: state.to));
                            } else {
                              context.read<RoutesBloc>().add(PointPicked(
                                  from: from,
                                  to: PinPoint(
                                      name: '', location: LatLng(0.0, 0.0))));
                            }
                          }))
                },
                decoration: InputDecoration(
                  hintText: 'From',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: TextField(
                controller: toController,
                readOnly: true,
                onTap: () {
                  Navigator.pushNamed(context, SearchPage.route,
                      arguments: ScreenArgumentsRoutesArgs(
                          name: 'to ',
                          func: (LatLng loc, String name) {
                            final PinPoint to =
                                PinPoint(name: name, location: loc);
                            if (state is RoutesPinPoint) {
                              context
                                  .read<RoutesBloc>()
                                  .add(PointPicked(from: state.from, to: to));
                            } else {
                              context.read<RoutesBloc>().add(PointPicked(
                                  from: PinPoint(
                                      name: '', location: LatLng(0.0, 0.0)),
                                  to: to));
                            }
                          }));
                },
                decoration: InputDecoration(
                  hintText: 'To',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SearchResults(),
            )
          ],
        ),
      );
    });
  }
}
