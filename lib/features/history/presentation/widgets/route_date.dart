import 'package:bus_navigation/core/utils/colors.dart';
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
        style: TextStyle(
            color: AppColors.greyAccent,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
