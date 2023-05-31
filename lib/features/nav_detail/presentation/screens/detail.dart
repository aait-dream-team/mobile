// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bus_navigation/features/nav_detail/presentation/widgets/train_mode.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/walk_expanded.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/walk_mode.dart';
import 'package:bus_navigation/features/navigate/presentation/screens/navigation_screen.dart';
import 'package:bus_navigation/features/search_results/models/RouteResultModel.dart';
import 'package:bus_navigation/features/search_results/presentation/widgets/route_result.dart';
import 'package:flutter/material.dart';

import 'package:bus_navigation/core/utils/utils.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/bus_mode.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/detail.dart';

import '../../model/nav_detail_model.dart';

class SidePage extends StatefulWidget {
  static const String route = '/SidePage';
  final NavDetailModel navDetailModel;
  const SidePage({
    Key? key,
    required this.navDetailModel,
  }) : super(key: key);

  @override
  _SidePageState createState() => _SidePageState();
}

class _SidePageState extends State<SidePage> {
  final double _expandedWidth = 400.0;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          title: RouteWidget(
            result: RouteSearchResultModel(
                departureInMinutes: 15,
                transports: [
                  const Transport(RouteSegmentType.train, "S1"),
                  const Transport(RouteSegmentType.tram, "U6"),
                ],
                totalDuration: 45,
                departureTime: DateTime(2023, 4, 24, 19, 30),
                arrivalTime: DateTime(2023, 4, 24, 20, 15),
                walkingTime: 10),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.play_arrow),
            label: Text('Start'),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    RouteWidget(
                      result: RouteSearchResultModel(
                          departureInMinutes: 15,
                          transports: [
                            const Transport(RouteSegmentType.train, "S1"),
                            const Transport(RouteSegmentType.tram, "U6"),
                          ],
                          totalDuration: 45,
                          departureTime: DateTime(2023, 4, 24, 19, 30),
                          arrivalTime: DateTime(2023, 4, 24, 20, 15),
                          walkingTime: 10),
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(child: NavigationPage()),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 30,
                        ),
                        width: _isExpanded ? _expandedWidth : 150.0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Container(
                                width: 200,
                                height: 200,
                                child: Card(
                                  child: Container(
                                    color: Colors.white,
                                    child: Icon(
                                      _isExpanded
                                          ? Icons.arrow_forward_ios
                                          : Icons.arrow_back_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 70,
                                            ),
                                            Card(
                                              child: Container(
                                                width: 150,
                                                color: Colors.white,
                                                child: List1(
                                                  navDetailModel:
                                                      widget.navDetailModel,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: _isExpanded,
                                        child: Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 70,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                  ),
                                                  width: 300,
                                                  child: List2(
                                                    navDetailModel:
                                                        widget.navDetailModel,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // RouteWidget(
                    //   result: RouteSearchResultModel(
                    //       departureInMinutes: 15,
                    //       transports: [
                    //         const Transport(RouteSegmentType.train, "S1"),
                    //         const Transport(RouteSegmentType.tram, "U6"),
                    //       ],
                    //       totalDuration: 45,
                    //       departureTime: DateTime(2023, 4, 24, 19, 30),
                    //       arrivalTime: DateTime(2023, 4, 24, 20, 15),
                    //       walkingTime: 10),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class List1 extends StatelessWidget {
  final NavDetailModel navDetailModel;
  List1({
    Key? key,
    required this.navDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> modes = [];
    for (var i = 0; i < navDetailModel.legs.length; i++) {
      if (navDetailModel.legs[i].mode == "WALK") {
        modes.add(WalkMode(leg: navDetailModel.legs[i]));
      } else if (navDetailModel.legs[i].mode == "BUS") {
        modes.add(BusMode(leg: navDetailModel.legs[i]));
      } else {
        modes.add(TrainMode(leg: navDetailModel.legs[i]));
      }
    }

    return Column(children: modes);
  }
}

class List2 extends StatelessWidget {
  final NavDetailModel navDetailModel;
  const List2({
    Key? key,
    required this.navDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> modes = [];
    for (var i = 0; i < navDetailModel.legs.length; i++) {
      if (navDetailModel.legs[i].mode == "WALK") {
        modes.add(WalkModeExpanded(leg: navDetailModel.legs[i]));
      } else {
        modes.add(Detail(leg: navDetailModel.legs[i]));
      }
    }

    return Column(children: modes);
  }
}
