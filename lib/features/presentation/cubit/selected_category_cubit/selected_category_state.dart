part of 'selected_category_cubit.dart';

@immutable
sealed class SelectedCategoryState {}

final class SelectedCategoryInitialState extends SelectedCategoryState {
  String category;
  SelectedCategoryInitialState([this.category = 'all']);
}

final class SelectedCategoryChangedState extends SelectedCategoryState {
  String category;
  int index;
  SelectedCategoryChangedState(this.category, this.index);
}
