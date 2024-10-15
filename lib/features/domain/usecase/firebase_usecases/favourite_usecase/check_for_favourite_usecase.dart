import 'package:fork_and_fusion/features/domain/repository/favourite_repo.dart';

class CheckForFavouriteUsecase {
  FavouriteRepo repo;
  CheckForFavouriteUsecase(this.repo);
  Future<bool> call(String id) async {
    return await repo.checkForFavourite(id);
  }
}
