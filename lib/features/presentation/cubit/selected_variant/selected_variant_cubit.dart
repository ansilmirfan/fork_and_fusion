import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_variant_state.dart';

class SelectedVariantCubit extends Cubit<SelectedVariantState> {
  SelectedVariantCubit() : super(SelectedVariantInitialState(''));
  void onReset() => emit(SelectedVariantInitialState(''));
  void onSelectionChanged(String key) {
    emit(SelectedVariantInitialState(key));
  }
}
