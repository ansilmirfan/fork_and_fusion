import 'package:fork_and_fusion/features/domain/repository/favourite_repo.dart';

class AddToFavouriteUsecase {
  FavouriteRepo repo;
  AddToFavouriteUsecase(this.repo);
  Future<bool> call(String id) async {
    return await repo.addToFavourite(id);
  }
}
