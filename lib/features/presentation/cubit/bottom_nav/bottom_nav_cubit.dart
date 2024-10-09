import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavPageChanageState(0));
  onPageChanage(int index) => emit(BottomNavPageChanageState(index));
}
