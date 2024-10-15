part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitialState extends FavouriteState {}

final class FavouriteLoadingState extends FavouriteState {}

final class FavouriteErrorState extends FavouriteState {
  String message;
  FavouriteErrorState(this.message);
}

final class FavouriteCompletedState extends FavouriteState {
  List<ProductEntity> favourite;
  FavouriteCompletedState(this.favourite);
}
final class FavoriteUpdatedState extends FavouriteState{}

final class FavouriteStatusState extends FavouriteState {
  bool isInFavourite;
  FavouriteStatusState(this.isInFavourite);
}
