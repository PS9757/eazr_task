import 'package:bloc/bloc.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/search/model/search_docs_model.dart';
import 'package:eazr/domain/search/usecase/search_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'search_event.dart';

part 'search_state.dart';

@Injectable()
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;

  SearchBloc(this.searchUseCase) : super(SearchInitial()) {
    on<SearchInitialEvent>((event, emit) async => await _searchInitial(emit));
    on<SearchQueryChangedEvent>(
        (event, emit) async => await _searchQueryChanged(event, emit));
    on<ScrollToBottomEvent>((event, emit) async => await _scrollToBottom(emit));
  }

  Future<void> _scrollToBottom(Emitter<SearchState> emit) async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit((state as SearchLoaded).copyWith(isLoadingMoreData: true));
      final currentPage = currentState.searchData.length ~/ 10;
      final result = await searchUseCase.call(SearchUseCaseParams(
        query: currentState.query,
        page: currentPage + 1,
      ));
      result.fold(
        (failure) {
          emit(SearchError(message: failure));
        },
        (searchData) {
          emit(
            SearchLoaded(
              searchData: currentState.searchData + searchData,
              isLoadingMoreData: false,
            ),
          );
        },
      );
    }
  }

  Future<void> _searchQueryChanged(
      SearchQueryChangedEvent event, Emitter<SearchState> emit) async {
    final currentState = state;
    int currentPage = (currentState as SearchLoaded).searchData.length ~/ 10;
    {
      if (event.query.isEmpty) {
        add(SearchInitialEvent());
      } else {
        emit(SearchLoading());
        final result = await searchUseCase.call(SearchUseCaseParams(
          query: event.query,
          page: currentPage + 1,
        ));
        result.fold(
          (failure) {
            emit(SearchError(message: failure));
          },
          (searchData) {
            emit(
              SearchLoaded(
                searchData: searchData,
                query: event.query,
              ),
            );
          },
        );
      }
    }
  }

  Future<void> _searchInitial(Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await searchUseCase.call(SearchUseCaseParams(
      query: '',
      page: 1,
    ));
    result.fold(
      (failure) => emit(SearchError(message: failure)),
      (searchData) {
        debugPrint('SearchData: $searchData');
        emit(SearchLoaded(searchData: searchData));
      },
    );
  }
}
