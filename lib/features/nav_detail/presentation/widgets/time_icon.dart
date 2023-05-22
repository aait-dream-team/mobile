// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum TimeType {
  start,
  end,
  transit,
}

class TimeIcon extends StatelessWidget {
  final TimeType type;
  final String time;

  const TimeIcon({
    Key? key,
    required this.type,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    switch (type) {
      case TimeType.start:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      case TimeType.end:
        backgroundColor = Colors.red;
        textColor = Colors.grey;
        break;
      case TimeType.transit:
        backgroundColor = Colors.blue;
        textColor = Colors.white;
        break;
    }

    return Chip(
      backgroundColor: backgroundColor,
      label: Text(
        style: TextStyle(
          color: textColor,
        ),
        time,
      ),
    );
  }
}
