import 'package:fork_and_fusion/features/domain/entity/category.dart';

abstract class CategoryRepo {
  Future<List<CategoryEntity>> getAllCategory();
}
