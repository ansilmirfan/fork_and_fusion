part of 'selected_variant_cubit.dart';

@immutable
sealed class SelectedVariantState {}

final class SelectedVariantInitialState extends SelectedVariantState {
  String selected;
  SelectedVariantInitialState(this.selected);
}
