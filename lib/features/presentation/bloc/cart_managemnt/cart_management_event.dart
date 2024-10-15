part of 'cart_management_bloc.dart';

@immutable
sealed class CartManagementEvent {}

final class CartManagementAddToCartEvent extends CartManagementEvent {
  CartEntity cart;
  CartManagementAddToCartEvent(this.cart);
}

final class CartManagementDeleteEvent extends CartManagementEvent {
  List<CartEntity> data;
  CartManagementDeleteEvent(this.data);
}

final class CartManagementEditEvent extends CartManagementEvent {
  CartEntity newData;
  CartManagementEditEvent(this.newData);
}

final class CartManagementCheckForDuplicate extends CartManagementEvent {
  String productId;
  String selectedVarinat;
  bool parcel;
  CartManagementCheckForDuplicate(
      {required this.parcel,
      required this.productId,
      required this.selectedVarinat});
}

final class CartManagemntGetAllEvent extends CartManagementEvent {
  bool fromEvent;
  CartManagemntGetAllEvent({this.fromEvent = false});
}

final class CartManagementUpdateQuantityEvent extends CartManagementEvent {
  bool increase;
  CartEntity cart;
  CartManagementUpdateQuantityEvent(this.increase, this.cart);
}

final class CartManagementUpdateParcelStatusEvent extends CartManagementEvent {
  CartEntity cart;
  CartManagementUpdateParcelStatusEvent(this.cart);
}

final class CartManagementSelectedEvent extends CartManagementEvent {
  CartEntity cart;
  CartManagementSelectedEvent(this.cart);
}

final class CartManagementDeleteOneEvent extends CartManagementEvent {
  String id;
  CartManagementDeleteOneEvent(this.id);
}

final class CartManagementProceedToBuyEvent extends CartManagementEvent {}

final class CartManagementPlaceOrderEvent extends CartManagementEvent {
  OrderEntity order;
  CartManagementPlaceOrderEvent(this.order);
}
