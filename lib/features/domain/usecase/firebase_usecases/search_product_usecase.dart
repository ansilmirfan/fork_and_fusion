import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/product_repo.dart';


class SearchProductUsecase {
  ProductRepo repo;
  SearchProductUsecase(this.repo);
  Future<List<ProductEntity>> call(String querry) async {
    return await repo.searchProducts(querry);
  }
}
