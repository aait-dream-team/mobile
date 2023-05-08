// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bus_navigation/features/history/models/RouteHistory.dart';
import 'package:bus_navigation/features/history/presentation/widgets/route_card.dart';
import 'package:bus_navigation/features/history/presentation/widgets/route_date.dart';
import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';

class GroupedRoute extends StatelessWidget {
  final DateTime date;
  final List<RouteModel> routes;
  const GroupedRoute({
    Key? key,
    required this.date,
    required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        sliver: MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverStack(insetOnOverlap: true, children: [buildCard()])
          ],
        ));
  }

  Widget buildCard() => MultiSliver(children: [
        SliverPinnedHeader(
          child: RouteDate(date: date),
        ),
        SliverClip(child: MultiSliver(children: [buildRoutes()]))
      ]);

  Widget buildRoutes() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => RouteHistoryCard(route: routes[index]),
          childCount: routes.length,
        ),
      );
}
