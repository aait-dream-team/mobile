// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:bus_navigation/core/local_notification/local_notification.dart';
import 'package:bus_navigation/core/text_to_speech/tts.dart';
import 'package:bus_navigation/features/history/data_provider/route_history_data_provider.dart';
import 'package:bus_navigation/features/history/models/RouteHistory.dart';
import 'package:bus_navigation/features/history/repository/route_history_repository.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/left_floating_action_button.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/stops.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/train_mode.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/walk_expanded.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/walk_mode.dart';
import 'package:bus_navigation/features/navigate/presentation/widgets/navigation_map.dart';
import 'package:bus_navigation/features/search_results/models/RouteResultModel.dart';
import 'package:bus_navigation/features/search_results/presentation/widgets/route_result.dart';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';

import 'package:bus_navigation/core/utils/utils.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/bus_mode.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../navigate/bloc/navigation_bloc.dart';
import '../../../navigate/data_provider/navigation_data_provider.dart';
import '../../../navigate/repository/navigation_repository.dart';
import '../../../routes/models/pin.dart';
import '../../model/nav_detail_model.dart';

class SidePage extends StatefulWidget {
  static const String route = '/SidePage';
  final MapController mapController = MapController();
  final NavDetailModel navDetailModel;
  final RouteSearchResultModel routeSearchResultModel;
  final PinPoint fromPin, toPin;
  final NavigationRepository repository =
      NavigationRepository(dataProvider: NavigationDataProvider());
  final RouteHistoryRepository routeHistoryRepository =
      RouteHistoryRepository(dataProvider: RouteHistoryDataProvider());

  SidePage(
      {Key? key,
      required this.navDetailModel,
      required this.routeSearchResultModel,
      required this.fromPin,
      required this.toPin})
      : super(key: key);

  @override
  _SidePageState createState() => _SidePageState();
}

class _SidePageState extends State<SidePage> with WidgetsBindingObserver {
  final double _expandedWidth = 400.0;
  bool _isExpanded = false;
  bool isStarted = false;
  bool _isNavigationStarted = false;
  late Floating floating;
  bool isPipAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    floating = Floating();
    requestPipAvailable();
    WidgetsBinding.instance.addObserver(this);
  }

  void requestPipAvailable() async {
    isPipAvailable = await floating.isPipAvailable;
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    floating.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint(state.toString());
    if (state == AppLifecycleState.inactive) {
      if (isPipAvailable && _isNavigationStarted) {
        floating.enable(aspectRatio: const Rational(2, 3));
      }
    }
  }

  onPause() {}

  void connectToWebSocket() {
    print('before');
    print(widget.navDetailModel.legs);
    print('after');
    String url = "ws://34.125.99.126";

    for (var leg in widget.navDetailModel.legs) {
      if (leg.mode != 'WALK') {
        print(leg.agencyId);
        print(leg.tripId);
        print(leg.routeId);
        for (String conStr in [
          'agency_${leg.agencyId}',
          'route_${leg.routeId}',
          'trip_${leg.tripId}'
        ])
          WebSocketChannel.connect(
                  Uri.parse('$url/ws/trip/notification/$conStr/'))
              .stream
              .listen((message) {
            var data = jsonDecode(message);
            print(data);
            LocalNotificationDataProvider.instantNotify(
                title: data['message']['effect_field'],
                body: data["message"]['message']);
            TextToSpeechSingleton tts = TextToSpeechSingleton();
            tts.speak(data['message']['message']);
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    connectToWebSocket();
    return PiPSwitcher(
      childWhenDisabled: BlocProvider(
          create: (context) => NavigationBloc(repository: widget.repository)
            ..add(LoadNavigationEvent(
                polylineString: widget.navDetailModel.legs
                    .map((e) => e.legGeometry)
                    .cast<String>()
                    .toList(),
                navDetailModel: widget.navDetailModel,
                fromPin: widget.fromPin,
                toPin: widget.toPin)),
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BlocConsumer<NavigationBloc, NavigationState>(
                builder: ((context, state) {
                  if (state is NavigationRoutingState &&
                      !_isNavigationStarted) {
                    _isNavigationStarted = true;

                    String text =
                        'You have started your navigation  to ${widget.toPin.name}';
                    // Notify user that their navigation has started
                    LocalNotificationDataProvider.instantNotify(
                        title: 'Navigation Started', body: text);
                    TextToSpeechSingleton tts = TextToSpeechSingleton();
                    tts.speak(text);

                    // Save the navigation to History
                    widget.routeHistoryRepository.addRoute(RouteModel(
                      startPoint: widget.fromPin.name,
                      endPoint: widget.toPin.name,
                      date: DateTime.now(),
                    ));
                  }

                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    extendBodyBehindAppBar: true,
                    floatingActionButton: (state is NavigationRoutingState)
                        ? FloatingActionButton.extended(
                            label: const Text('Cancel'), // <-- Text
                            backgroundColor: Colors.redAccent,
                            icon: const Icon(
                              // <-- Icon
                              Icons.cancel,
                              size: 24.0,
                            ),
                            onPressed: () {
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(CancelNavigationEvent());
                            },
                          )
                        : FloatingActionButton.extended(
                            label: const Text('Start'), // <-- Text
                            backgroundColor: Colors.green,
                            icon: const Icon(
                              // <-- Icon
                              Icons.play_circle,
                              size: 24.0,
                            ),
                            onPressed: () {
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(StartNavigationEvent());
                            },
                          ),
                    floatingActionButtonLocation:
                        const LeftFloatingActionButtonLocation(),
                    body: SafeArea(
                      child: Column(
                        children: [
                          (state is NavigationRoutingState)
                              ? Stops(
                                  title: state
                                          .navDetailModel
                                          .legs[state.currentIndex]
                                          ?.intermidateStops?[
                                              state.currentIntermidateStopIndex]
                                          .name ??
                                      'Walking',
                                  arrivalTime: state
                                          .navDetailModel
                                          .legs[state.currentIndex]
                                          ?.intermidateStops?[
                                              state.currentIntermidateStopIndex]
                                          .arrivalTime ??
                                      DateTime.now(),
                                )
                              : RouteWidget(
                                  result: widget.routeSearchResultModel,
                                  navDetailModel: widget.navDetailModel,
                                ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: NavigateMapWidget(
                                        navDetailModel: widget.navDetailModel,
                                        mapController: widget.mapController,
                                      ),
                                    )),
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
                                          icon: SizedBox(
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
                                                        GestureDetector(
                                                          onPanUpdate:
                                                              (details) {
                                                            int sensitivity = 0;
                                                            if (details.delta
                                                                        .dy >
                                                                    sensitivity ||
                                                                details.delta
                                                                        .dy <
                                                                    -sensitivity) {
                                                              setState(() {
                                                                _isExpanded =
                                                                    !_isExpanded;
                                                              });
                                                            }
                                                          },
                                                          child: Card(
                                                            child: Container(
                                                              width: 150,
                                                              color:
                                                                  Colors.white,
                                                              child: List1(
                                                                currentIndex: (state
                                                                        is NavigationRoutingState)
                                                                    ? state
                                                                        .currentIndex
                                                                    : -1,
                                                                navDetailModel:
                                                                    widget
                                                                        .navDetailModel,
                                                              ),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                              width: 300,
                                                              child: List2(
                                                                navDetailModel:
                                                                    widget
                                                                        .navDetailModel,
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
                                if (state is NavigationRoutingState)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: GestureDetector(
                                        onTap: () {
                                          widget.mapController.move(
                                              state.userPointInRoute, 16.0);
                                        },
                                        child: const CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.blueAccent,
                                          child: Center(
                                            child: Icon(
                                              Icons.navigation_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                listenWhen: (previous, current) {
                  if (previous is NavigationRoutingState &&
                      current is NavigationRoutingState) {
                    if (previous.currentIndex != current.currentIndex &&
                        current.navDetailModel.legs[current.currentIndex]
                                .mode ==
                            'BUS') {
                      return true;
                    }
                    return previous.currentIndex == current.currentIndex &&
                        current.navDetailModel.legs[current.currentIndex]
                                .mode ==
                            'BUS' &&
                        current.currentIntermidateStopIndex !=
                            previous.currentIntermidateStopIndex;
                  }

                  return false;
                },
                listener: (BuildContext context, NavigationState state) {
                  if (state is NavigationRoutingState) {
                    String speak = state
                        .navDetailModel
                        .legs[state.currentIndex]
                        .intermidateStops![state.currentIntermidateStopIndex]
                        .name;

                    TextToSpeechSingleton tts = TextToSpeechSingleton();
                    tts.speak(speak);
                  }
                },
              ))),
      childWhenEnabled: BlocProvider(
        create: (context) => NavigationBloc(repository: widget.repository)
          ..add(LoadNavigationEvent(
              polylineString: widget.navDetailModel.legs
                  .map((e) => e.legGeometry)
                  .cast<String>()
                  .toList(),
              navDetailModel: widget.navDetailModel,
              fromPin: widget.fromPin,
              toPin: widget.toPin)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<NavigationBloc, NavigationState>(
            builder: ((context, state) {
              if (state is NavigationRoutingState && !_isNavigationStarted) {
                _isNavigationStarted = true;

                String text = 'You have started your navigation  to Bole';
                // Notify user that their navigation has started
                LocalNotificationDataProvider.instantNotify(
                    title: 'Navigation Started', body: text);
                TextToSpeechSingleton tts = TextToSpeechSingleton();
                tts.speak(text);
              }

              return Scaffold(
                  backgroundColor: Colors.transparent,
                  extendBodyBehindAppBar: true,
                  body: SafeArea(
                    child: Column(children: [
                      Expanded(
                        child: Stack(children: [
                          Container(
                            color: Colors.white,
                            child: Center(
                              child: NavigateMapWidget(
                                navDetailModel: widget.navDetailModel,
                                mapController: widget.mapController,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ));
            }),
          ),
        ),
      ),
    );
  }
}

class List1 extends StatelessWidget {
  final NavDetailModel navDetailModel;
  final int currentIndex;
  const List1(
      {Key? key, required this.navDetailModel, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> modes = [];
    for (var i = 0; i < navDetailModel.legs.length; i++) {
      if (navDetailModel.legs[i].mode == "WALK") {
        modes.add(WalkMode(
          leg: navDetailModel.legs[i],
          index: i,
          currentIndex: currentIndex,
        ));
      } else if (navDetailModel.legs[i].mode == "BUS") {
        modes.add(BusMode(
          leg: navDetailModel.legs[i],
          index: i,
          currentIndex: currentIndex,
        ));
      } else {
        modes.add(TrainMode(
          leg: navDetailModel.legs[i],
          index: i,
          currentIndex: currentIndex,
        ));
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
