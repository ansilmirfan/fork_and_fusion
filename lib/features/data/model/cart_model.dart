import 'package:fork_and_fusion/features/data/model/category_model.dart';
import 'package:fork_and_fusion/features/data/model/product_model.dart';
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
      super.rated,
      super.status,
      super.repaid,
      super.isSelected});
  factory CartModel.fromMap(Map<String, dynamic> map, ProductEntity product) {
    return CartModel(
      id: map['id'],
      product: product,
      quantity: map['quantity'],
      cookingRequest: map['cooking request'],
      parcel: map['parcel'],
      status: map['status'] ?? 'Processing',
      rated: map['rated'] ?? false,
      selectedType: map['selected type'],
      isSelected: map['selected'],
      repaid: map['repaid'] ?? false,
    );
  }
  static Map<String, dynamic> toMap(CartEntity cart) {
    return {
      'id': cart.id,
      'product': cart.product.id,
      'status': cart.status.isEmpty ? 'Processing' : cart.status,
      'quantity': cart.quantity,
      'parcel': cart.parcel,
      'cooking request': cart.cookingRequest,
      'selected type': cart.selectedType,
      'rated': cart.rated,
      'selected': cart.isSelected,
      'repaid': cart.repaid,
    };
  }

  static Map<String, dynamic> toMapWhole(CartEntity cart) {
    return {
      'id': cart.id,
      'product': productToMap(cart.product),
      'quantity': cart.quantity,
      'status': cart.status,
      'parcel': cart.parcel,
      'cooking request': cart.cookingRequest,
      'rated': cart.rated,
      'selected type': cart.selectedType,
      'selected': cart.isSelected,
      'repaid': cart.repaid,
    };
  }

  static Map<String, dynamic> productToMap(ProductEntity product) {
    return {
      'product': ProductModel.toMap(product),
      'categories': product.category.map((e) => CategoryModel.toMap(e)).toList()
    };
  }
}
