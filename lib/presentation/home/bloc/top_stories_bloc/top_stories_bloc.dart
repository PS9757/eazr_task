import 'package:bloc/bloc.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/home/model/top_stories_model.dart';
import 'package:eazr/domain/home/usecase/get_top_stories_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'top_stories_event.dart';

part 'top_stories_state.dart';

@injectable
class TopStoriesBloc extends Bloc<TopStoriesEvent, TopStoriesState> {
  final GetTopStoriesUseCase getTopStoriesUseCase;

  TopStoriesBloc(this.getTopStoriesUseCase) : super(TopStoriesInitial()) {
    on<GetTopStoriesEvent>((event, emit) => _onGetTopStoriesEvent(event, emit));
    on<InfiniteScrollEvent>(
        (event, emit) => _onInfiniteScrollEvent(event, emit));
  }

  void _onInfiniteScrollEvent(
      InfiniteScrollEvent event, Emitter<TopStoriesState> emit) {
    if (state is! TopStoriesLoaded) return;

    final TopStoriesLoaded currentState = state as TopStoriesLoaded;
    final originalData = currentState.topStoriesModelOriginalData;
    final topStories = currentState.topStoriesModel;

    // Calculate the start and end indices for sublist safely
    final startIndex = topStories.length;
    final endIndex = (startIndex + 10).clamp(0, originalData.length);

    // Ensure there is new data to load
    if (topStories.length == originalData.length) {
      return;
    }

    final newTopStories = originalData.sublist(startIndex, endIndex);
    debugPrint('Length of the top stories: ${topStories.length}');

    emit(currentState.copyWith(
      topStoriesModel: [...topStories, ...newTopStories],
    ));
  }

  void _onGetTopStoriesEvent(
      GetTopStoriesEvent event, Emitter<TopStoriesState> emit) async {
    emit(TopStoriesLoading());
    final topStoriesResult = await getTopStoriesUseCase.call(null);
    topStoriesResult.fold(
      (failure) => emit(TopStoriesError(failure)),
      (topStories) => emit(TopStoriesLoaded(
        topStoriesModel: topStories.sublist(0, 10),
        topStoriesModelOriginalData: topStories,
      )),
    );
  }
}
