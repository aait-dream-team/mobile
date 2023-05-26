part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadFailedState extends SearchState {
  final String msg;

  SearchLoadFailedState({
    required this.msg,
  });
}

class SearchSuccessState extends SearchState {
  final List<RouteSearchResultModel> result;

  SearchSuccessState({
    required this.result,
  });
}
