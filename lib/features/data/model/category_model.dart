

import 'package:fork_and_fusion/features/domain/entity/category.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required super.name,
      required super.image,
      required super.id,
      super.file});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(name: map['name'], image: map['image'], id: map['id']);
  }
  static Map<String, dynamic> toMap(CategoryEntity data) {
    Map<String, dynamic> map = {
      'name': data.name,
      'image': data.image,
      'id': data.id,
    };
    return map;
  }
}
