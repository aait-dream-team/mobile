import 'package:bus_navigation/features/routes/model/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import './search_routes_page.dart';
import '../../bloc/routes_bloc.dart';
import 'screen_arguments.dart';
import 'package:bus_navigation/features/search_results/presentation/screens/search_result_page.dart';

class RoutesPage extends StatefulWidget {
  static const String route = "/routes";

  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesWidget();
}

class _RoutesWidget extends State<RoutesPage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesBloc, RoutesState>(builder: (context, state) {
      if (state is RoutesPinPoint) {
        fromController.text = '${state.from.name}, ${state.from.location}';
        toController.text = '${state.to.name}, ${state.to.location}';
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
                      arguments: ScreenArguments(
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
                  prefixIcon: Icon(Icons.location_on),
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
                      arguments: ScreenArguments(
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
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              // child: ListView.separated(
              //   itemCount: 0,
              //   separatorBuilder: (BuildContext context, int index) =>
              //       Divider(color: Colors.grey[300]), // lighter divider color
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       leading:
              //           Icon(Icons.location_on_outlined), // location pin icon
              //       title: Text('Location $index'), // title of the suggestion
              //       subtitle:
              //           Text('Subtitle $index'), // subtitle of the suggestion
              //       trailing: Icon(Icons
              //           .copy), // copy icon at the most left side of the row
              //     );
              //   },
              // ),
              child: SearchResults(),
            )
          ],
        ),
      );
    });
  }
}