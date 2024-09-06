import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousal_index_event.dart';
part 'carousal_index_state.dart';

class CarousalIndexBloc extends Bloc<CarousalIndexEvent, CarousalIndexState> {
  CarousalIndexBloc() : super(CarousalIndexInitial(0)) {
    on<CarousalIndexChangedEvent>(carousalIndexEvent);
  }

  FutureOr<void> carousalIndexEvent(
      CarousalIndexChangedEvent event, Emitter<CarousalIndexState> emit) {
    emit(CarousalIndexInitial(event.index));
  }
}
