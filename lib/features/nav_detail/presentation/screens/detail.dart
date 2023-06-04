// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bus_navigation/core/local_notification/local_notification.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/left_floating_action_button.dart';
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
  final RouteSearchResultModel routeSearchResultModel;

  const SidePage(
      {Key? key,
      required this.navDetailModel,
      required this.routeSearchResultModel})
      : super(key: key);

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
        floatingActionButton: ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 56.0,
              minHeight: 56.0), // Adjust the constraints as needed
          child: FloatingActionButton(
            onPressed: () async {
              // Add your desired action here

              await LocalNotificationDataProvider.instantNotify(
                  title: 'Start Navigation',
                  body: 'This simple notification is from Flutter App');
            },
            child: Container(
              width: 600,
              child: const Row(children: [
                Expanded(child: Icon(Icons.play_arrow)),
                Expanded(child: Text("Start")),
              ]),
            ),
          ),
        ),
        floatingActionButtonLocation: const LeftFloatingActionButtonLocation(),
        body: SafeArea(
          child: Column(
            children: [
              RouteWidget(
                result: widget.routeSearchResultModel,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Center(
                          child: NavigationPage(
                        polylineString: widget.navDetailModel.legs
                            .map((e) => e.legGeometry)
                            .cast<String>()
                            .toList(),
                      )),
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
                                            const SizedBox(
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
                                              const SizedBox(
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
