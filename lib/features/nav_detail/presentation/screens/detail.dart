// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        body: SafeArea(
          child: Column(
            children: [
              // const SizedBox(
              //   height: 100,
              // ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'Main Content',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
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
                                        child: Card(
                                          child: Container(
                                            width: 150,
                                            color: Colors.white,
                                            child: List1(
                                              navDetailModel:
                                                  widget.navDetailModel,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _isExpanded,
                                        child: Expanded(
                                          flex: 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                              ),
                                              width: 300,
                                              child: List2(
                                                navDetailModel:
                                                    widget.navDetailModel,
                                              )),
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
      modes.add(BusMode(leg: navDetailModel.legs[i]));
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
      modes.add(Detail(leg: navDetailModel.legs[i]));
    }

    return Column(children: modes);
  }
}
