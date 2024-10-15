import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/order_repo.dart';

class GetAllOrderUsecase {
  OrderRepo repo;
  GetAllOrderUsecase(this.repo);
  Stream<List<OrderEntity>> call() {
    return repo.getAllOrders();
  }
}
