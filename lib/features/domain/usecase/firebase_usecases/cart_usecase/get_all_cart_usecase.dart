import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/cart_repo.dart';

class GetAllCartUsecase {
  CartRepo repo;
  GetAllCartUsecase(this.repo);
  Future<List<CartEntity>> call() async {
    return await repo.getAll();
  }
}
