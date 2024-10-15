part of 'favourite_get_all_cubit.dart';

@immutable
sealed class FavouriteGetAllState {}

final class FavouriteGetAllInitial extends FavouriteGetAllState {}

final class FavouriteGetAllLoadingState extends FavouriteGetAllState {}

final class FavouriteGetAllCompletedState extends FavouriteGetAllState {
  List<ProductEntity> favourites;
  FavouriteGetAllCompletedState(this.favourites);
}

final class FavouriteGetAllErrorState extends FavouriteGetAllState {
  String message;
  FavouriteGetAllErrorState(this.message);
}
