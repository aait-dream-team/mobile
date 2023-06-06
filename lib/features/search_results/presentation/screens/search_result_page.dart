import 'package:bus_navigation/features/nav_detail/presentation/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc.dart';
import '../../data_provider/route_search_data_provider.dart';
import '../../repository/route_search_repository.dart';
import '../widgets/depature_datetime.dart';
import '../widgets/route_result.dart';

class SearchResults extends StatefulWidget {
  static const String route = "/search";
  final RouteSearchRepository repository =
      RouteSearchRepository(dataProvider: RouteSearchDataProvider());
  @override
  State<SearchResults> createState() => _RouteSearchState();
}

class _RouteSearchState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    int depature = 0;
    DateTime dateTime = DateTime.now();
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitialState) {
            return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text("Enter source and destination")));
          }
          if (state is SearchInitialState || state is SearchLoadingState) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator(strokeWidth: 7)),
            );
          }
          if (state is SearchLoadFailedState) {
            return Center(child: Text(state.msg));
          }
          if (state is SearchSuccessState) {
            final list = state.results;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SearchBloc>().add(LoadSearchEvent(
                    departureDate: state.departureDate,
                    from: state.from,
                    to: state.to));
              },
              child: CustomScrollView(
                slivers: list
                    .map((route) => SliverToBoxAdapter(
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            color: Colors.black26,
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, SidePage.route,
                                  arguments: [route.$1, route.$2]),
                              child: RouteWidget(
                                result: route.$1,
                              ),
                            ))))
                    .cast<SliverToBoxAdapter>()
                    .toList(),
              ),
            );
          }
          return const Center(child: Text("Something Went Wrong"));
        },
      ),
      bottomSheet: const Text(
        "Search results don't belong here. Here for testing purposes",
      ),
    );
  }
}
