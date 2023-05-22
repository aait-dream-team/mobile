import 'package:bus_navigation/core/utils/utils.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/bus_mode.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/detail.dart';
import 'package:bus_navigation/features/nav_detail/presentation/widgets/walk_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SidePage extends StatefulWidget {
  static const String route = '/d';

  @override
  _SidePageState createState() => _SidePageState();
}

class _SidePageState extends State<SidePage> {
  int _counter = 0;
  final ValueNotifier<double> _sheetWidthNotifier = ValueNotifier(200.0);
  final double _expandedWidth = 400.0;
  bool _isExpanded = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller1 = ScrollController();
    bool _isScrolling = false;

    final ScrollController _controller2 = ScrollController();

    // _controller1.addListener(() {
    //   _controller2.jumpTo(_controller1.offset);
    // });

    // _controller2.addListener(() {
    //   _controller1.jumpTo(_controller2.offset);
    // });

    // @override
    // void dispose() {
    //   _controller1.dispose();
    //   _controller2.dispose();
    //   super.dispose();
    // }

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
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
                                _isExpanded ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
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
                                      child: Column(children: [
                                        for (var i = 0; i < 50; i++)
                                          const BusMode()
                                      ]),
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
                                      child: Column(
                                        children: [
                                          for (var i = 0; i < 50; i++)
                                            const Detail()
                                        ],
                                      ),
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
      ),
    );
  }
}
