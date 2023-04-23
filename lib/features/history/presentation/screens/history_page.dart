import 'package:bus_navigation/features/history/presentation/widgets/grouped_route.dart';
import 'package:bus_navigation/features/history/presentation/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/history_bloc.dart';
import '../../data_provider/route_history_data_provider.dart';
import '../../repository/route_history_repository.dart';

class RouteHistory extends StatefulWidget {
  static const String route = "/history";
  final RouteHistoryRepository repository =
      RouteHistoryRepository(dataProvider: RouteHistoryDataProvider());
  RouteHistory({super.key});

  @override
  State<RouteHistory> createState() => _RouteHistoryState();
}

class _RouteHistoryState extends State<RouteHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Routes History",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5)),
            ],
          ),
        ),
        body: BlocProvider(
          create: (context) => HistoryBloc(repository: widget.repository)
            ..add(LoadHistoryEvent()),
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoadingState ||
                  state is HistoryInitialState) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: LoadingShimmer(),
                );
                // return const Center(child: CircularProgressIndicator(strokeWidth: 7));
              }
              if (state is HistoryLoadFailedState) {
                return Center(child: Text(state.msg));
              }
              if (state is HistorySuccessState) {
                final list = state.routes.values.toList(growable: false);

                return CustomScrollView(
                    slivers: list
                        .map((e) => GroupedRoute(date: e[0].date, routes: e))
                        .toList());
              }
              return const Center(child: Text("SomeThing Went Wrong"));

              // return CustomScrollView(slivers: buildSection());
            },
          ),
        ));
  }
}
