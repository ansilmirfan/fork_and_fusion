import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:meta/meta.dart';

part 'selected_category_state.dart';

class SelectedCategoryCubit extends Cubit<SelectedCategoryState> {
  SelectedCategoryCubit() : super(SelectedCategoryInitialState());
  void onSelectedCategory(
      String category, int index, List<ProductEntity>? data) {
    List<ProductEntity> filtered = [];
    if (data != null) {
      if (category == 'all') {
        filtered = data;
      } else {
        filtered =
            data.where((e) => e.category.any((s) => s.id == category)).toList();
      }
    }

    emit(SelectedCategoryChangedState(category,index,filtered));
  }
}
