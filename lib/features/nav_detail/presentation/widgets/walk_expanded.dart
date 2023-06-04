import 'package:bus_navigation/features/nav_detail/model/nav_detail_model.dart';
import 'package:flutter/material.dart';

const Map<String, IconData> _relativeDirectionIcons = {
  'DEPART': Icons.directions_walk,
  'HARD_LEFT': Icons.turn_left,
  'LEFT': Icons.turn_left,
  'SLIGHTLY_LEFT': Icons.turn_slight_left,
  'SLIGHTLY_RIGHT': Icons.turn_slight_right,
  'RIGHT': Icons.turn_right,
  'HARD_RIGHT': Icons.turn_right,
  'CIRCLE_CLOCKWISE': Icons.rotate_left,
  'CIRCLE_COUNTERCLOCKWISE': Icons.rotate_right,
  'ELEVATOR': Icons.elevator,
  'UTURN_LEFT': Icons.u_turn_left,
  'UTURN_RIGHT': Icons.u_turn_right,
  "CONTINUE": Icons.arrow_upward,
};

class WalkModeExpanded extends StatefulWidget {
  final Leg leg;

  const WalkModeExpanded({Key? key, required this.leg}) : super(key: key);

  @override
  _WalkModeExpandedState createState() => _WalkModeExpandedState();
}

class _WalkModeExpandedState extends State<WalkModeExpanded> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // flex: 2,
                  child: Text(
                      "${(widget.leg.distance! / 1000).toStringAsFixed(2)} km"),
                ),
                Expanded(
                    // flex: 1,
                    child: Text("${widget.leg.duration ~/ 60} min")),
                Visibility(
                  visible: widget.leg.steps!.length > 1,
                  child: Expanded(
                    // flex: 2,
                    child: SizedBox(
                      // width: 95,
                      child: PopupMenuButton(
                          // child: Text("Steps"),
                          icon: const Row(
                            children: [
                              Expanded(child: Text('Steps')),
                              Expanded(child: Icon(Icons.arrow_drop_down)),
                            ],
                          ),
                          onSelected: (value) {
                            setState(() {
                              // _selectedStep = value;
                            });
                          },
                          itemBuilder: (context) => widget.leg.steps!.map((e) {
                                return PopupMenuItem(
                                  value: e.streetName,
                                  child: ListTile(
                                    leading: Icon(_relativeDirectionIcons[
                                        e.relativeDirection]!),
                                    title: Text(e.streetName),
                                    subtitle: Text(
                                        "${(e.distance / 1000).toStringAsFixed(2)} km"),
                                  ),
                                );
                              }).toList()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
