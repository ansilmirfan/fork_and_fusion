import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/favourite_usecase/add_to_favourite_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/favourite_usecase/check_for_favourite_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/favourite_usecase/favourite_get_all_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/favourite_usecase/remove_from_favourite_usecase.dart';
import 'package:meta/meta.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitialState()) {
    on<CheckForFavouriteEvent>(checkForFavouriteEvent);
    on<AddToFavouriteEvent>(addToFavouriteEvent);
    on<RemoveFromFavouriteEvent>(removeFromFavouriteEvent);
    on<GetAllFavouriteEvent>(getAllFavouriteEvent);
  }

  FutureOr<void> checkForFavouriteEvent(
      CheckForFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoadingState());
    try {
      CheckForFavouriteUsecase usecase =
          CheckForFavouriteUsecase(Services.favouriteRepository());
      final result = await usecase.call(event.id);
      emit(FavouriteStatusState(result));
    } catch (e) {
      log(e.toString());
      emit(FavouriteErrorState('Network error $e'));
    }
  }

  FutureOr<void> addToFavouriteEvent(
      AddToFavouriteEvent event, Emitter<FavouriteState> emit) async {
    try {
      AddToFavouriteUsecase usecase =
          AddToFavouriteUsecase(Services.favouriteRepository());
      await usecase.call(event.id);
      add(CheckForFavouriteEvent(event.id));
    } catch (e) {
      log(e.toString());
      emit(FavouriteErrorState('Network error $e'));
    }
  }

  FutureOr<void> removeFromFavouriteEvent(
      RemoveFromFavouriteEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoadingState());
    try {
      RemoveFromFavouriteUsecase usecase =
          RemoveFromFavouriteUsecase(Services.favouriteRepository());
      await usecase.call(event.id);
      add(CheckForFavouriteEvent(event.id));
    } catch (e) {
      log(e.toString());
      emit(FavouriteErrorState('Network error $e'));
    }
  }

  FutureOr<void> getAllFavouriteEvent(
      GetAllFavouriteEvent event, Emitter<FavouriteState> emit) async {
    try {
      FavouriteGetAllUsecase usecase =
          FavouriteGetAllUsecase(Services.favouriteRepository());
      final result = await usecase.call();
      emit(FavouriteCompletedState(result));
    } catch (e) {
      emit(FavouriteErrorState('Network error'));
    }
  }
}
