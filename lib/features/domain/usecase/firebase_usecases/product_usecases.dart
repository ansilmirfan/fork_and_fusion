import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/product_repo.dart';

class ProductUsecases {
  ProductRepo repo;
  ProductUsecases(this.repo);
  Stream<List<ProductEntity>> call() {
    return repo.featchAllProducts();
  }
}
