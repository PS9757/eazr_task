import 'package:bloc/bloc.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/home/model/top_stories_model.dart';
import 'package:eazr/domain/home/entity/most_popular_entity.dart';
import 'package:eazr/domain/home/usecase/get_popular_news_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPopularNewsUseCase getPopularNewsUseCase;

  HomeBloc(
    this.getPopularNewsUseCase,
  ) : super(HomeInitial()) {
    on<GetPopularNewsEvent>(
        (event, emit) async => await _onGetPopularNewsEvent(event, emit));
  }

  // Future<void> _onGetTopStoriesEvent(
  //     GetTopStoriesEvent event, Emitter<HomeState> emit) async {
  //   try {
  //     emit((state as HomeLoaded).copyWith(topStoriesStatus: Status.loading));
  //     final topStoriesResult = await getTopStoriesUseCase.call(null);
  //
  //     topStoriesResult.fold(
  //       (failure) async {
  //         emit(
  //           (state as HomeLoaded).copyWith(
  //             topStoriesStatus: Status.error,
  //           ),
  //         );
  //       },
  //       (topStories) {
  //         emit(
  //           (state as HomeLoaded).copyWith(
  //             topStoriesModel: topStories,
  //             topStoriesModelOriginalData: topStories,
  //             topStoriesStatus: Status.loaded,
  //           ),
  //         );
  //         add(InfiniteScrollEvent());
  //       },
  //     );
  //   } catch (e) {
  //     emit(HomeError(UnknownFailure()));
  //   }
  // }
  //
  // Future<void> _onGetContentDataEvent(
  //     GetContentDataEvent event, Emitter<HomeState> emit) async {
  //   // try {
  //   //   emit(
  //   //     (state as HomeLoaded).copyWith(
  //   //       topStoriesStatus: Status.loading,
  //   //     ),
  //   //   );
  //   //   final contentResult = await getContentDataUseCase.call(null);
  //   //   contentResult.fold(
  //   //     (failure) async {
  //   //       emit(
  //   //         (state as HomeLoaded).copyWith(
  //   //           topStoriesStatus: Status.error,
  //   //         ),
  //   //       );
  //   //     },
  //   //     (contentData) {
  //   //       emit(
  //   //         (state as HomeLoaded).copyWith(
  //   //           topStoriesModel: contentData,
  //   //           topStoriesModelOriginalData: contentData,
  //   //           topStoriesStatus: Status.loaded,
  //   //         ),
  //   //       );
  //   //     },
  //   //   );
  //   // } catch (e) {
  //   //   emit(HomeError(UnknownFailure()));
  //   // }
  // }
  //
  // Future<void> _onGetSectionListEvent(
  //     GetSectionListEvent event, Emitter<HomeState> emit) async {
  //   try {
  //     emit(
  //       (state as HomeLoaded).copyWith(
  //         sectionStatus: Status.loading,
  //       ),
  //     );
  //     final sectionResult = await getSectionListUseCase.call(null);
  //     sectionResult.fold(
  //       (failure) async {
  //         emit(
  //           (state as HomeLoaded).copyWith(
  //             sectionStatus: Status.error,
  //           ),
  //         );
  //       },
  //       (sectionData) {
  //         emit(
  //           (state as HomeLoaded).copyWith(
  //             sectionData: sectionData,
  //             sectionStatus: Status.loaded,
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     emit(HomeError(UnknownFailure()));
  //   }
  // }

  Future<void> _onGetPopularNewsEvent(
      GetPopularNewsEvent event, Emitter<HomeState> emit) async {
    try {
      // First, emit loading state
      emit(HomeLoading());

      // Fetch popular news
      final popularResult = await getPopularNewsUseCase.call(null);
      // final sectionResult = await getSectionListUseCase.call(null);
      // final contentResult = await getContentDataUseCase.call(null);
      await popularResult.fold(
        // If there's a failure, emit error state
        (failure) async {
          emit(HomeError(failure));
          return;
        },
        // If successful, proceed to fetch section data
        (popularModel) async {
          emit(
            HomeLoaded(
              popularModel: popularModel,
              topStoriesModel: [],
              topStoriesModelOriginalData: [],
            ),
          );
        },
      );
    } catch (e) {
      // Catch any unexpected errors
      emit(HomeError(UnknownFailure()));
    }
  }

  @override
  void onChange(Change<HomeState> change) {
    debugPrint(change.toString());
    super.onChange(change);
  }
}
