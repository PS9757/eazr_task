import 'package:bloc/bloc.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/category/model/category_model.dart';
import 'package:eazr/domain/category/usecase/get_content_data_usecase.dart';
import 'package:eazr/domain/category/usecase/get_section_list_usecase.dart';
import 'package:injectable/injectable.dart';

part 'category_event.dart';

part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetSectionListUseCase getSectionListUseCase;
  final GetContentDataUseCase getContentDataUseCase;

  CategoryBloc(this.getSectionListUseCase, this.getContentDataUseCase)
      : super(CategoryInitial()) {
    on<CategoryLoad>((event, emit) async => _onCategoryLoad(event, emit));
    on<CategorySelect>((event, emit) async => _onCategorySelect(event, emit));
    on<ContentLoad>((event, emit) async => _onContentLoad(event, emit));
  }

  void _onContentLoad(ContentLoad event, Emitter<CategoryState> emit) async {
    final result = await getContentDataUseCase.call(
      (state as CategoryLoaded).selectedCategory,
    );
    result.fold(
      (failure) => emit(CategoryError(failure)),
      (contents) => emit(
        (state as CategoryLoaded).copyWith(
          contents: contents,
        ),
      ),
    );
  }

  void _onCategorySelect(CategorySelect event, Emitter<CategoryState> emit) {
    emit(
      (state as CategoryLoaded).copyWith(
        selectedCategory: event.selectedCategory,
      ),
    );
    add(ContentLoad());
  }

  void _onCategoryLoad(CategoryLoad event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await getSectionListUseCase.call(null);
    result.fold(
      (failure) => emit(CategoryError(failure)),
      (categories) {
        emit(CategoryLoaded(
          categories: categories,
        ));
        add(ContentLoad());
      },
    );
  }
}
