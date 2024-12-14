part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  SearchLoaded({
    required this.searchData,
    this.query = '',
    this.isLoadingMoreData = false,
  });

  final List<SearchDocsModel> searchData;
  final String query;
  final bool isLoadingMoreData;

  SearchLoaded copyWith({
    List<SearchDocsModel>? searchData,
    String? query,
    bool? isLoadingMoreData,
  }) {
    return SearchLoaded(
      searchData: searchData ?? this.searchData,
      query: query ?? this.query,
      isLoadingMoreData: isLoadingMoreData ?? this.isLoadingMoreData,
    );
  }
}

final class SearchError extends SearchState {
  SearchError({required this.message});

  final Failure message;
}
