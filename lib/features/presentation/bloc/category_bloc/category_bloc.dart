import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/features/data/repositories/category_repository.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/repository/category_repo.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/category_usecase.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryGetAllEvent>(categoryGetAllEvent);
  }

  FutureOr<void> categoryGetAllEvent(
      CategoryGetAllEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    try {
      CategoryRepo repo = CategoryRepository();
      CategoryUsecase usecase = CategoryUsecase(repo);
      final data = await usecase.call();
      data.sort((a, b) => a.name.compareTo(b.name));
      emit(CategoryCompletedState(data));
    } catch (e) {
      emit(CategoryErrorState('Network error please try again'));
    }
  }
}
