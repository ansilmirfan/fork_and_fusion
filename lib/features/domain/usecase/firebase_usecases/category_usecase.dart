import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/repository/category_repo.dart';

class CategoryUsecase {
  CategoryRepo repo;
  CategoryUsecase(this.repo);
  Future<List<CategoryEntity>> call() async {
    return await repo.getAllCategory();
  }
}
