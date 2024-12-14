part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<MostPopularEntity>? popularModel;
  final List<TopStoriesModel> topStoriesModel;
  final List<TopStoriesModel> topStoriesModelOriginalData;

  HomeLoaded({
    this.popularModel,
    required this.topStoriesModel,
    required this.topStoriesModelOriginalData,
  });

  //copyWith method
  HomeLoaded copyWith({
    List<MostPopularEntity>? popularModel,
    List<TopStoriesModel>? topStoriesModel,
    Failure? topStoriesFailure,
    Status? topStoriesStatus,
    List<TopStoriesModel>? topStoriesModelOriginalData,
  }) {
    return HomeLoaded(
      popularModel: popularModel ?? this.popularModel,
      topStoriesModel: topStoriesModel ?? this.topStoriesModel,
      topStoriesModelOriginalData:
          topStoriesModelOriginalData ?? this.topStoriesModelOriginalData,
    );
  }
}

final class HomeError extends HomeState {
  final Failure failure;

  HomeError(this.failure);
}

enum Status { initial, loading, loaded, error }
