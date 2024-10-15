import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/order_repo.dart';

class PlaceOrderUsecase {
  OrderRepo repo;
  PlaceOrderUsecase(this.repo);
  Future<void> call(OrderEntity order) async {
    await repo.placeOrder(order);
  }
}
