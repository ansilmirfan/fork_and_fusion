import 'package:fork_and_fusion/features/domain/entity/product.dart';

abstract class FavouriteRepo {
  Future<bool> addToFavourite(String id);
  Future<bool> removeFavourite(String id);
  Future<List<ProductEntity>> getAllFavourite();
  Future<bool> checkForFavourite(String productId);
}
