import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/order_repo.dart';

class CancelOrderUsecase {
  OrderRepo repo;
  CancelOrderUsecase(this.repo);
  Future<bool> call(OrderEntity order) async {
    return repo.canecelOrder(order);
  }
}
