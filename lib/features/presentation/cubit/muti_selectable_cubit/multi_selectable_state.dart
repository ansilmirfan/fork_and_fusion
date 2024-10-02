part of 'multi_selectable_cubit.dart';

@immutable
sealed class MultiSelectableState {}

final class MultiSelectableInitial extends MultiSelectableState {}

final class MultiSelectableLoadingState extends MultiSelectableState {}

final class MultiSelectableCompletedState extends MultiSelectableState {
  List<CategoryEntity> categories;
  bool selectAll;
  MultiSelectableCompletedState(this.categories, this.selectAll);
}

final class MultiSelectableErrorState extends MultiSelectableState {
  String message;
  MultiSelectableErrorState(this.message);
}
