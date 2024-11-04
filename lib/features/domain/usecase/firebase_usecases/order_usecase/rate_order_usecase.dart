import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/order_repo.dart';

class RateOrderUsecase {
  OrderRepo repo;
  RateOrderUsecase(this.repo);
  Future<bool> call(OrderEntity order, String productId, int rating) async {
    return await repo.orderRating(order, productId, rating);
  }
}
