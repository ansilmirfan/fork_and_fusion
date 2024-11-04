part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderGetAllEvent extends OrderEvent {}

final class OrderCancelEvent extends OrderEvent {
  OrderEntity order;
  OrderCancelEvent(this.order);
}

final class OrderRatingEvent extends OrderEvent {
  OrderEntity order;
  int rating;
  String productId;
  OrderRatingEvent(this.order, this.rating, this.productId);
}
