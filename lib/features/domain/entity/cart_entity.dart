import 'package:fork_and_fusion/features/domain/entity/product.dart';

class CartEntity {
  String id;
  ProductEntity product;
  int quantity;
  bool parcel;
  bool isSelected;
  String cookingRequest;
  bool rated;
  String status;
  String selectedType;
  bool repaid;
  CartEntity(
      {required this.id,
      required this.product,
      required this.quantity,
      this.cookingRequest = '',
      this.parcel = false,
      this.status = 'Processing',
      this.isSelected = false,
      this.rated = false,
      this.selectedType = '',
      this.repaid = false,
      });
}
