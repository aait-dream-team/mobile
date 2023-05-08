import 'package:bus_navigation/features/search/bloc/search_bloc.dart';
import 'package:bus_navigation/features/search/data_provider/route_search_data_provider.dart';
import 'package:bus_navigation/features/search/repository/route_search_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../widgets/route_result.dart';

class SearchResults extends StatefulWidget {
  static const String route = "/search";
  final RouteSearchRepository repository =
      RouteSearchRepository(dataProvider: RouteSearchDataProvider());
  SearchResults({super.key});

  @override
  State<SearchResults> createState() => _RouteSearchState();
}

class _RouteSearchState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white12,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Search Results",
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
        create: (context) =>
            SearchBloc(repository: widget.repository)..add(LoadSearchEvent()),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitialState || state is SearchLoadingState) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator(strokeWidth: 7)),
              );
              // return const Center(child: CircularProgressIndicator(strokeWidth: 7));
            }
            if (state is SearchLoadFailedState) {
              return Center(child: Text(state.msg));
            }
            if (state is SearchSuccessState) {
              final list = state.result;

              return CustomScrollView(
                  slivers: list
                      .map((route) => SliverToBoxAdapter(
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              color: Colors.black26,
                              child: RouteWidget(
                                result: route,
                              ))))
                      .cast<SliverToBoxAdapter>()
                      .toList());
            }
            return const Center(child: Text("SomeThing Went Wrong"));

            // return CustomScrollView(slivers: buildSection());
          },
        ),
      ),
      bottomSheet: const Text(
        "Search results don't belong here. Here for testing purposes",
      ),
    );
  }
}
