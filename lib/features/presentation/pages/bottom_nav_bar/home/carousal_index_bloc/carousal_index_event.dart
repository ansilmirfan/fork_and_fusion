part of 'carousal_index_bloc.dart';

@immutable
sealed class CarousalIndexEvent {
  
}
class CarousalIndexChangedEvent extends CarousalIndexEvent{
  int index;
  CarousalIndexChangedEvent(this.index);
}
