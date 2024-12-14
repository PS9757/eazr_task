part of 'category_bloc.dart';


sealed class CategoryEvent {}

final class CategoryLoad extends CategoryEvent {}

final class CategorySelect extends CategoryEvent {
  final String selectedCategory;

  CategorySelect(this.selectedCategory);
}

final class ContentLoad extends CategoryEvent {}
