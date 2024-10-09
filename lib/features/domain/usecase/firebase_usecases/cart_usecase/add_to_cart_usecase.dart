import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/cart_repo.dart';

class AddToCartUsecase {
  CartRepo repo;
  AddToCartUsecase(this.repo);
  Future<bool> call(CartEntity data) async {
    return await repo.addToCart(data);
  }
}
