// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/features/data/repositories/category_repository.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/repository/category_repo.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/category_usecase.dart';
import 'package:meta/meta.dart';

part 'multi_selectable_state.dart';

class MultiSelectableCubit extends Cubit<MultiSelectableState> {
  MultiSelectableCubit() : super(MultiSelectableInitial());

  List<CategoryEntity> category = [];
  void loadAllCategories() async {
    emit(MultiSelectableLoadingState());
    CategoryRepo repo = CategoryRepository();
    try {
      CategoryUsecase usecase = CategoryUsecase(repo);
      var categories = await usecase.call();
      categories.sort((a, b) => a.name.compareTo(b.name));
      categories = categories.where((e) => e.selected = true).toList();
      category = categories;
      emit(MultiSelectableCompletedState(categories, true));
    } catch (e) {
      emit(MultiSelectableErrorState('Netork Error Please try again'));
    }
  }

  void updateSelectedField(int index) {
    if (category.isEmpty) {
      loadAllCategories();
    }
    category[index].selected = !category[index].selected;
    bool selectAll = category.every((e) => e.selected);
    emit(MultiSelectableCompletedState(category, selectAll));
  }

  void selectAllCategoty() {
    bool selectAll = (state as MultiSelectableCompletedState).selectAll;
    selectAll = !selectAll;
    if (selectAll) {
      category.forEach((e) => e.selected = true);
    } else {
      category.forEach((e) => e.selected = false);
    }

    emit(MultiSelectableCompletedState(category, selectAll));
  }
}
