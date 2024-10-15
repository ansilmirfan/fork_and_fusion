part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitialState extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class OrderErrorState extends OrderState {
  String message;
  OrderErrorState(this.message);
}

final class OrderCompletedState extends OrderState {
  List<OrderEntity> orders;
  OrderCompletedState(this.orders);
}
