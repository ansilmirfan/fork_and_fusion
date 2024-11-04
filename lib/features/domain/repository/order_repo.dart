import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';

abstract class OrderRepo {
  Future<void> placeOrder(OrderEntity order);
  Stream<List<OrderEntity>> getAllOrders();
  Future<bool> canecelOrder(OrderEntity order);
  Future<bool> orderRating(OrderEntity order, String productId, int rating);
}
