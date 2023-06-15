import 'package:bus_navigation/features/history/presentation/widgets/loading_shimmer.dart';
import 'package:bus_navigation/features/nav_detail/presentation/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc.dart';
import '../../data_provider/route_search_data_provider.dart';
import '../../repository/route_search_repository.dart';
import '../widgets/route_result.dart';

class SearchResults extends StatefulWidget {
  static const String route = "/search";
  final RouteSearchRepository repository =
      RouteSearchRepository(dataProvider: RouteSearchDataProvider());

  SearchResults({super.key});
  @override
  State<SearchResults> createState() => _RouteSearchState();
}

class _RouteSearchState extends State<SearchResults> with SingleTickerProviderStateMixin{
   late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    int depature = 0;
    DateTime dateTime = DateTime.now();
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitialState) {
            return  Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Image.asset("assets/source_dest.png", height: 200,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Enter source and destination", style: TextStyle(fontSize: 23,fontWeight: FontWeight.w100),),
                    ),
                  ],
                )));
          }
          if (state is SearchInitialState || state is SearchLoadingState) {
            return const Padding(
              padding: EdgeInsets.all(6.0),
              child: LoadingShimmer(),
            );
          }
          if (state is SearchLoadFailedState) {
            return RefreshIndicator(
                onRefresh: () async {
                  context.read<SearchBloc>().add(LoadSearchEvent(
                      departureDate: state.departureDate,
                      from: state.from,
                      to: state.to,
                      isDepartureTime: state.isDepartureTime,
                      fromPin: state.fromPin,
                      toPin: state.toPin
                      ));
                },
                child: Center(child: Text(state.msg)));
          }
          if (state is SearchSuccessState) {
            final list = state.results;

            return (list.isNotEmpty)?RefreshIndicator(
              onRefresh: () async {
                context.read<SearchBloc>().add(LoadSearchEvent(
                    departureDate: state.departureDate,
                    from: state.from,
                    to: state.to,
                    isDepartureTime: state.isDepartureTime,
                    fromPin: state.fromPin,
                    toPin: state.toPin));
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
                                  arguments: [route.$1, route.$2, state.fromPin, state.toPin]),
                              child: RouteWidget(
                                  result: route.$1, navDetailModel: route.$2),
                            ))))
                    .cast<SliverToBoxAdapter>()
                    .toList(),
              ),
            ):Center(child: AnimatedOpacity(
      opacity: _animation.value,
      duration: const Duration(milliseconds: 500),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No Possible Routes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try with different source and destination',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ),);
          }
          return const Center(child: Text("Something Went Wrong"));
        },
      ),
    );
  }
}
