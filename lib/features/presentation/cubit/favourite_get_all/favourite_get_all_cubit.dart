import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/favourite_usecase/favourite_get_all_usecase.dart';
import 'package:meta/meta.dart';

part 'favourite_get_all_state.dart';

class FavouriteGetAllCubit extends Cubit<FavouriteGetAllState> {
  FavouriteGetAllCubit() : super(FavouriteGetAllInitial());
  void getAll() async {
    emit(FavouriteGetAllLoadingState());
    try {
      FavouriteGetAllUsecase usecase =
          FavouriteGetAllUsecase(Services.favouriteRepository());
      final result = await usecase.call();
      emit(FavouriteGetAllCompletedState(result));
    } catch (e) {
      emit(FavouriteGetAllErrorState('Network Error'));
    }
  }
}
