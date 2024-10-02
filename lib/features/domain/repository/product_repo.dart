import 'package:fork_and_fusion/features/domain/entity/product.dart';


abstract class ProductRepo {
  Stream<List<ProductEntity>> featchAllProducts();
  Future<List<ProductEntity>> searchProducts(String querry);
}
