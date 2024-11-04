part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitialState extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class OrderRatingCompletedState extends OrderState {
  String productId;
  OrderRatingCompletedState(this.productId);
}

final class OrderErrorState extends OrderState {
  String message;
  OrderErrorState(this.message);
}

final class OrderCompletedState extends OrderState {
  List<OrderEntity> orders;
  OrderCompletedState(this.orders);
}

final class OrderCancelLoadingEvent extends OrderState {}
