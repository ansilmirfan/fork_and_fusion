part of 'bottom_nav_cubit.dart';

@immutable
sealed class BottomNavState {}

final class BottomNavPageChanageState extends BottomNavState {
  int index;
  BottomNavPageChanageState(this.index);
}
