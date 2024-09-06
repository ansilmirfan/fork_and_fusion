import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quantity_event.dart';
part 'quantity_state.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  QuantityBloc() : super(QuantityInitialState(1, false)) {
    on<QuantityAddEvent>(quantityAddEvent);
    on<QuantityReduceEvent>(quantityReduceEvent);
    on<ParcelEvent>(parcelEvent);
  }

  FutureOr<void> quantityReduceEvent(
      QuantityReduceEvent event, Emitter<QuantityState> emit) {
    if (state is QuantityInitialState) {
      int current = (state as QuantityInitialState).quantity;
      bool parcel = (state as QuantityInitialState).parcel;
      if (current != 1) {
        emit(QuantityInitialState(current - 1, parcel));
      }
    }
  }

  FutureOr<void> quantityAddEvent(
      QuantityAddEvent event, Emitter<QuantityState> emit) {
    if (state is QuantityInitialState) {
      int current = (state as QuantityInitialState).quantity;
      bool parcel = (state as QuantityInitialState).parcel;
      if (current != 10) {
        emit(QuantityInitialState(current + 1, parcel));
      }
    }
  }

  FutureOr<void> parcelEvent(ParcelEvent event, Emitter<QuantityState> emit) {
    if (state is QuantityInitialState) {
      int current = (state as QuantityInitialState).quantity;
      bool parcel = (state as QuantityInitialState).parcel;
      parcel = !parcel;
      emit(QuantityInitialState(current, parcel));
    }
  }
}
