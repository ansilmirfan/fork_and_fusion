import 'package:fork_and_fusion/features/domain/entity/product.dart';

class CartEntity {
  String id;
  ProductEntity product;
  int quantity;
  bool parcel;
  bool isSelected;
  String cookingRequest;
  String selectedType;
  CartEntity(
      {required this.id,
      required this.product,
      required this.quantity,
      this.cookingRequest = '',
      this.parcel = false,
      this.isSelected = false,
      this.selectedType = ''});
}
