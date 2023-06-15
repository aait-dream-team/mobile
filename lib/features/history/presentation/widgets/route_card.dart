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
      child: Card(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 20,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          route.startPoint,
                          style: TextStyle(
                            color: AppColors.blackAccent,
                          ),
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
                      color: AppColors.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        route.endPoint,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.blackAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
