import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';

class CartModel extends CartEntity {
  CartModel(
      {required super.id,
      required super.product,
      required super.quantity,
      super.parcel,
      super.cookingRequest,
      super.selectedType,
      super.isSelected});
  factory CartModel.fromMap(Map<String, dynamic> map, ProductEntity product) {
    return CartModel(
      id: map['id'],
      product: product,
      quantity: map['quantity'],
      cookingRequest: map['cooking request'],
      parcel: map['parcel'],
      selectedType: map['selected type'],
      isSelected: map['selected'],
    );
  }
  static Map<String, dynamic> toMap(CartEntity cart) {
    return {
      'id': cart.id,
      'product': cart.product.id,
      'quantity': cart.quantity,
      'parcel': cart.parcel,
      'cooking request': cart.cookingRequest,
      'selected type': cart.selectedType,
      'selected': cart.isSelected
    };
  }
}
