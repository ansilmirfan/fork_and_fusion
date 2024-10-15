import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.ingredients,
      required super.category,
      super.variants,
      super.price,
      super.offer,
      super.file,
      super.type,
      super.rating});
  factory ProductModel.fromMap(
      Map<String, dynamic> map, List<CategoryEntity> category) {
    return ProductModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        image: List<String>.from(map['image']),
        price: map['price'] ?? 0,
        ingredients: map['ingredients'] ?? '',
        category: category,
        offer: map['offer'] ?? 0,
        variants: map['variants'],
        rating: List<int>.from(map['rating'] ?? []),
        type: stringToEnumList(List<String>.from(map['type'])));
  }
  static Map<String, dynamic> toMap(ProductEntity data) {
    Map<String, dynamic> map = {
      'id': data.id,
      'name': data.name,
      'image': data.image,
      'price': data.price,
      'ingredients': data.ingredients,
      'category': extractCategoryId(data.category),
      'offer': data.offer,
      'variants': data.variants,
      'type': enumToStringList(data.type),
    };
    return map;
  }

  //--------------enum convertion-------------------
  static List<ProductType> stringToEnumList(List<String> data) {
    if (data.isEmpty) {
      return [];
    }
    final converted = data.map((e) => stringToEnum(e)).toList();
    return converted;
  }

  static List<String> enumToStringList(List<ProductType> data) {
    if (data.isEmpty) {
      return [];
    }
    final converted = data.map((e) => e.name).toList();
    return converted;
  }

  static ProductType stringToEnum(String typeString) {
    switch (typeString) {
      case 'seasonal':
        return ProductType.seasonal;
      case 'todays_special':
        return ProductType.todays_special;
      case 'todays_list':
        return ProductType.todays_list;
      default:
        throw Exception('No such enum value: $typeString');
    }
  }

  static List<String> extractCategoryId(List<CategoryEntity> data) {
    return data.map((e) => e.id).toList();
  }
}
