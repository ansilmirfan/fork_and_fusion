import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_category_state.dart';

class SelectedCategoryCubit extends Cubit<SelectedCategoryState> {
  SelectedCategoryCubit() : super(SelectedCategoryInitialState());
  void onSelectedCategory(String category,int index) {
    emit(SelectedCategoryChangedState(category,index));
  }
}
