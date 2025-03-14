part of 'cart_management_bloc.dart';

@immutable
sealed class CartManagementState {}

final class CartManagementInitialState extends CartManagementState {}

final class CartManagementLoadingState extends CartManagementState {}

final class CartManagementErrorState extends CartManagementState {
  String message;
  CartManagementErrorState(this.message);
}

final class CartManagementCompletedState extends CartManagementState {
  List<CartEntity> cart;
  bool isSelected;
  int selectedLength;
  int subtotal;
  CartManagementCompletedState(this.cart, this.isSelected, this.selectedLength,this.subtotal);
}

final class CartManagementNetWorkErrorState extends CartManagementState {}

final class CartManagementAddedToCartState extends CartManagementState {}

final class CartManagementGoToCartState extends CartManagementState {}

final class CartManagementItemNotInCartState extends CartManagementState {}

final class CartManagementEditedState extends CartManagementState {}

final class CartManagementPoceedsToBuyState extends CartManagementState {
  String clientId;
  String url;
  String secretKey;
  CartManagementPoceedsToBuyState(
      {required this.clientId, required this.secretKey, required this.url});
}
