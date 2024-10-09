import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';

abstract class CartRepo {
  Future<List<CartEntity>> getAll();
  Future<bool> addToCart(CartEntity data);
  Future<bool> updateCart(CartEntity newData);
  Future<bool> deleteCart(String id);
  Future<bool> updateFewFields(String id, Map<String, dynamic> data);
  Future<bool> checkForDuplicate(CartEntity data);
}
