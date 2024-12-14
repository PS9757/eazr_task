part of 'top_stories_bloc.dart';

@immutable
sealed class TopStoriesState {}

final class TopStoriesInitial extends TopStoriesState {}

final class TopStoriesLoading extends TopStoriesState {}

final class TopStoriesLoaded extends TopStoriesState {
  final List<TopStoriesModel> topStoriesModel;
  final List<TopStoriesModel> topStoriesModelOriginalData;

  TopStoriesLoaded({
    required this.topStoriesModel,
    required this.topStoriesModelOriginalData,
  });

  //copyWith method
  TopStoriesLoaded copyWith({
    List<TopStoriesModel>? topStoriesModel,
    List<TopStoriesModel>? topStoriesModelOriginalData,
  }) {
    return TopStoriesLoaded(
      topStoriesModel: topStoriesModel ?? this.topStoriesModel,
      topStoriesModelOriginalData:
          topStoriesModelOriginalData ?? this.topStoriesModelOriginalData,
    );
  }
}

final class TopStoriesError extends TopStoriesState {
  final Failure failure;

  TopStoriesError(this.failure);
}
