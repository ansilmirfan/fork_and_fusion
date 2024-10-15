part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteEvent {}

final class CheckForFavouriteEvent extends FavouriteEvent {
  String id;
  CheckForFavouriteEvent(this.id);
}

final class AddToFavouriteEvent extends FavouriteEvent {
  String id;
  AddToFavouriteEvent(this.id);
}

final class RemoveFromFavouriteEvent extends FavouriteEvent {
  String id;
  RemoveFromFavouriteEvent(this.id);
}
final class GetAllFavouriteEvent extends FavouriteEvent{}
