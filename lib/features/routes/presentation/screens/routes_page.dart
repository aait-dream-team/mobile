// import 'package:bus_navigation/features/routes/model/pin.dart';
import 'package:bus_navigation/features/routes/presentation/screens/screen_arguments_routes.dart';
import 'package:bus_navigation/features/search_results/bloc/search_bloc.dart';
import 'package:bus_navigation/features/search_results/presentation/widgets/depature_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../models/pin.dart';
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
  int depature = 0;
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutesBloc, RoutesState>(listener: (context, state) {
      if (state is RoutesPinPoint &&
          state.from.name != '' &&
          state.to.name != "") {
        context.read<SearchBloc>().add(LoadSearchEvent(
            from: state.from.location,
            to: state.to.location,
            departureDate: state.datetime,
            isDepartureTime: state.isDepartureTime,
            fromPin: state.from,
            toPin: state.to),);
      }
    }, builder: (context, state) {
      if (screenArgumentsRoutes != null) {
        if (screenArgumentsRoutes!.type == 'from') {
          context.read<RoutesBloc>().add(
                PointPicked(
                    from: PinPoint(
                        name: screenArgumentsRoutes!.name,
                        location: screenArgumentsRoutes!.location),
                    to: state is RoutesPinPoint
                        ? state.to
                        : PinPoint(name: '', location: LatLng(0.0, 0.0)),
                    datetime: state is RoutesPinPoint
                        ? state.datetime
                        : DateTime.now(),
                    isDepartureTime:
                        state is RoutesPinPoint ? state.isDepartureTime : true),
              );
        } else {
          context.read<RoutesBloc>().add(PointPicked(
              to: PinPoint(
                  name: screenArgumentsRoutes!.name,
                  location: screenArgumentsRoutes!.location),
              from: state is RoutesPinPoint
                  ? state.from
                  : PinPoint(name: '', location: LatLng(0.0, 0.0)),
              datetime:
                  state is RoutesPinPoint ? state.datetime : DateTime.now(),
              isDepartureTime:
                  state is RoutesPinPoint ? state.isDepartureTime : true));
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
                              context.read<RoutesBloc>().add(PointPicked(
                                  from: from,
                                  to: state.to,
                                  datetime: state.datetime,
                                  isDepartureTime: state.isDepartureTime));
                            } else {
                              context.read<RoutesBloc>().add(PointPicked(
                                  from: from,
                                  to: PinPoint(
                                      name: '', location: LatLng(0.0, 0.0)),
                                  datetime: DateTime.now(),
                                  isDepartureTime: true));
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
                              context.read<RoutesBloc>().add(PointPicked(
                                  from: state.from,
                                  to: to,
                                  datetime: state.datetime,
                                  isDepartureTime: state.isDepartureTime));
                            } else {
                              context.read<RoutesBloc>().add(PointPicked(
                                  from: PinPoint(
                                      name: '', location: LatLng(0.0, 0.0)),
                                  to: to,
                                  datetime: DateTime.now(),
                                  isDepartureTime: true));
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
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    context: context,
                    builder: (context) => DatePicker(
                      onSave: (dep, date) {
                        print(date);
                        if (state is RoutesPinPoint) {
                          context.read<RoutesBloc>().add(PointPicked(
                              from: state.from,
                              to: state.to,
                              datetime: date,
                              isDepartureTime: dep == 0));
                        } else {
                          context.read<RoutesBloc>().add(PointPicked(
                              from: PinPoint(
                                  name: '', location: LatLng(0.0, 0.0)),
                              to: PinPoint(
                                  name: '', location: LatLng(0.0, 0.0)),
                              datetime: date,
                              isDepartureTime: dep == 0));
                        }
                        return setState(() => {
                              Navigator.pop(context),
                              depature = dep,
                              dateTime = date,
                            });
                      },
                    ),
                  )
                },
                icon: Icon(
                  Icons.date_range_sharp,
                  color: Colors.black45,
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
