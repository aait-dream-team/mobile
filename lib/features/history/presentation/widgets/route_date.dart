import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RouteDate extends StatelessWidget {
  final DateTime date;
  const RouteDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        DateFormat.yMMMMEEEEd().format(date),
        style: const TextStyle(
            color: Color.fromARGB(255, 182, 180, 180),
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
