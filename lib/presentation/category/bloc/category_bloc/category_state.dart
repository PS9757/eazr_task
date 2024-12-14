part of 'category_bloc.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<Map<String, dynamic>> categories;
  final String selectedCategory;
  final List<CategoryModel> contents;

  CategoryLoaded({
    required this.categories,
    this.selectedCategory = 'all',
    this.contents = const [],
  });

  CategoryLoaded copyWith({
    List<Map<String, dynamic>>? categories,
    String? selectedCategory,
    List<CategoryModel>? contents,
  }) =>
      CategoryLoaded(
        categories: categories ?? this.categories,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        contents: contents ?? this.contents,
      );
}

final class CategoryError extends CategoryState {
  final Failure message;

  CategoryError(this.message);
}
