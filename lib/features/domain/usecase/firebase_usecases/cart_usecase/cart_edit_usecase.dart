import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/cart_repo.dart';

class CartEditUsecase {
  CartRepo repo;
  CartEditUsecase(this.repo);
  Future<bool> call(CartEntity newData) async {
    return await repo.updateCart(newData);
  }
}
