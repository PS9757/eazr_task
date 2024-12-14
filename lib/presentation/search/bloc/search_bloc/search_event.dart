part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchInitialEvent extends SearchEvent {}

final class SearchQueryChangedEvent extends SearchEvent {
  SearchQueryChangedEvent({required this.query});

  final String query;
}

final class ScrollToBottomEvent extends SearchEvent {}
