part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitialState extends CategoryState {}

final class CategoryLoadingState extends CategoryState {}

final class CategoryCompletedState extends CategoryState {
  List<CategoryEntity> categories;
  CategoryCompletedState(this.categories);
}

final class CategoryErrorState extends CategoryState {
  String message;
  CategoryErrorState(this.message);
}
