part of 'carousal_index_bloc.dart';

@immutable
sealed class CarousalIndexState {}

final class CarousalIndexInitial extends CarousalIndexState {
  int index;
  CarousalIndexInitial(this.index);
}
