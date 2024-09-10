part of 'cart_quantity_bloc.dart';

@immutable
sealed class CartQuantityState {}

final class CartQuantityInitialState extends CartQuantityState {
  int quantity;
  bool parcel;
  bool isSelected;
  CartQuantityInitialState(this.quantity, this.parcel,this.isSelected);
}
