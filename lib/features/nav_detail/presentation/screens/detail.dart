import 'package:bus_navigation/features/nav_detail/presentation/widgets/walk_mode.dart';
import 'package:flutter/material.dart';

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
                  duration: Duration(milliseconds: 30),
                  width: _isExpanded ? _expandedWidth : 200.0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isExpanded ? Icons.arrow_forward : Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                      ),
                      Expanded(
                        child: ClipRect(
                          child: Container(
                            color: Colors.grey[200],
                            child: ListView.builder(
                              itemCount: 25,
                              itemBuilder: (BuildContext context, int index) {
                                return const WalkMode();
                              },
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isExpanded,
                        child: ClipRect(
                          child: Container(
                            color: Colors.black54,
                            width: 200.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Extra Information',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isExpanded = false;
                                      });
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
