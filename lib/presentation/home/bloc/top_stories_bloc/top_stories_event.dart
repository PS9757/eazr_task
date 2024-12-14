part of 'top_stories_bloc.dart';

@immutable
sealed class TopStoriesEvent {}

class GetTopStoriesEvent extends TopStoriesEvent {
  GetTopStoriesEvent();
}

class InfiniteScrollEvent extends TopStoriesEvent {}
