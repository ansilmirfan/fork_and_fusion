import 'package:fork_and_fusion/features/domain/repository/cart_repo.dart';

class CartUpdateFewUsecase {
  CartRepo repo;
  CartUpdateFewUsecase(this.repo);
  Future<bool> call(String id, String field, dynamic value) {
    return repo.updateFewFields(id, {field: value});
  }
}
