import 'package:fork_and_fusion/features/domain/repository/cart_repo.dart';

class CartDeleteUsecase {
  CartRepo repo;
  CartDeleteUsecase(this.repo);
  Future<bool> call(String id) async {
    return await repo.deleteCart(id);
  }
}
