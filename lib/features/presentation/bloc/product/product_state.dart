part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitialState extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductCompletedState extends ProductState {
  List<ProductEntity> data;
  ProductCompletedState(this.data);
}

final class ProductErrorState extends ProductState {
  String message;
  ProductErrorState(this.message);
}
