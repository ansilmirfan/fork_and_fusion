import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quantity_event.dart';
part 'quantity_state.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  int quantity = 1;
  bool parcelStatus = false;
  QuantityBloc() : super(QuantityInitialState(1, false)) {
    on<QuantityInitialEvent>(quantityInitialEvent);
    on<QuantityAddEvent>(quantityAddEvent);
    on<QuantityReduceEvent>(quantityReduceEvent);
    on<ParcelEvent>(parcelEvent);
    on<QuantityResetEvent>(quantityResetEvent);
  }

  FutureOr<void> quantityReduceEvent(
      QuantityReduceEvent event, Emitter<QuantityState> emit) {
    if (state is QuantityInitialState) {
      int current = (state as QuantityInitialState).quantity;
      bool parcel = (state as QuantityInitialState).parcel;
      if (current != 1) {
        quantity -= 1;
        emit(QuantityInitialState(current - 1, parcel));
      }
    }
  }

  FutureOr<void> quantityAddEvent(
      QuantityAddEvent event, Emitter<QuantityState> emit) {
    if (state is QuantityInitialState) {
      int current = (state as QuantityInitialState).quantity;
      bool parcel = (state as QuantityInitialState).parcel;

      quantity += 1;
      emit(QuantityInitialState(current + 1, parcel));
    }
  }

  FutureOr<void> parcelEvent(ParcelEvent event, Emitter<QuantityState> emit) {
    if (state is QuantityInitialState) {
      int current = (state as QuantityInitialState).quantity;
      bool parcel = (state as QuantityInitialState).parcel;
      parcel = !parcel;
      parcelStatus = parcel;
      emit(QuantityInitialState(current, parcel));
    }
  }

  FutureOr<void> quantityResetEvent(
      QuantityResetEvent event, Emitter<QuantityState> emit) {
    emit(QuantityInitialState(1, false));
    parcelStatus = false;
    quantity = 1;
  }

  FutureOr<void> quantityInitialEvent(
      QuantityInitialEvent event, Emitter<QuantityState> emit) {
    emit(QuantityInitialState(event.quantity, event.parcel));
    quantity = event.quantity;
    parcelStatus = event.parcel;
  }
}
