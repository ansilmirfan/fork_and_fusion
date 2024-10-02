part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FeatchAllProducts extends ProductEvent {}

final class SearchProductEvent extends ProductEvent {
  String querry;
  SearchProductEvent(this.querry);
}
