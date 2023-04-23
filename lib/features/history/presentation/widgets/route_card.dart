// ignore_for_file: public_member_api_docs, sort_constructors_first
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
              const Icon(
                Icons.circle_outlined,
                size: 20,
                color: Color.fromARGB(255, 225, 222, 222),
              ),
              const SizedBox(width: 10),
              Text(
                route.startPoint,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(200, 11, 11, 11),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.arrow_downward_outlined,
                color: Colors.grey,
                size: 17,
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.circle_rounded,
                size: 20,
                color: Color.fromARGB(113, 42, 122, 187),
              ),
              const SizedBox(width: 10),
              Text(
                route.endPoint,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromARGB(200, 11, 11, 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
