// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bus_navigation/core/utils/utils.dart';
import 'package:bus_navigation/features/history/models/RouteHistory.dart';
import 'package:flutter/material.dart';

class RouteHistoryCard extends StatelessWidget {
  final RouteModel route;

  const RouteHistoryCard({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.circle_outlined,
                size: 20,
                color: AppColors.whiteAccent,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  route.startPoint,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackAccent,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.arrow_downward_outlined,
                color: AppColors.grey,
                size: 17,
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.circle_rounded,
                size: 20,
                color: AppColors.blueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  route.endPoint,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.blackAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
