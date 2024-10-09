part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FeatchAllProducts extends ProductEvent {}

final class SearchProductEvent extends ProductEvent {
  String querry;
  SearchProductEvent(this.querry);
}
final class ProductFilterEvent extends ProductEvent {
  FilterStates nameState;
  FilterStates priceState;
  RangeValues rangeValues;
  List<CategoryEntity> selectedCategory;

  ProductFilterEvent(
      {required this.nameState,
      required this.priceState,
      required this.rangeValues,
      required this.selectedCategory});
}