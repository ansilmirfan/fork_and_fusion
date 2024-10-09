part of 'cart_management_bloc.dart';

@immutable
sealed class CartManagementState {}

final class CartManagementInitialState extends CartManagementState {}

final class CartManagementLoadingState extends CartManagementState {
  bool fromAnother;
  CartManagementLoadingState({this.fromAnother = false});
}

final class CartManagementErrorState extends CartManagementState {
  String message;
  CartManagementErrorState(this.message);
}

final class CartManagementCompletedState extends CartManagementState {
  List<CartEntity> cart;
  CartManagementCompletedState(this.cart);
}

final class CartManagementNetWorkErrorState extends CartManagementState {}

final class CartManagementAddedToCartState extends CartManagementState {}

final class CartManagementGoToCartState extends CartManagementState {}

final class CartManagementItemNotInCartState extends CartManagementState {}


final class CartManagementEditedState extends CartManagementState{}
