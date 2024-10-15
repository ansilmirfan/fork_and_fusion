import 'package:fork_and_fusion/features/domain/repository/favourite_repo.dart';

class RemoveFromFavouriteUsecase {
  FavouriteRepo repo;
  RemoveFromFavouriteUsecase(this.repo);
  Future<bool> call(String id) async {
    return await repo.removeFavourite(id);
  }
}
