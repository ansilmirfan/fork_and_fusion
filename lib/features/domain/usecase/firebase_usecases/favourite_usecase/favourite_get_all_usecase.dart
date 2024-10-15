import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/favourite_repo.dart';

class FavouriteGetAllUsecase {
  FavouriteRepo repo;
  FavouriteGetAllUsecase(this.repo);
  Future<List<ProductEntity>> call() async {
    return await repo.getAllFavourite();
  }
}
