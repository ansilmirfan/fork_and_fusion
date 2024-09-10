import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_quantity_event.dart';
part 'cart_quantity_state.dart';

class CartQuantityBloc extends Bloc<CartQuantityEvent, CartQuantityState> {
  CartQuantityBloc() : super(CartQuantityInitialState(1, false, false)) {
    on<CartQuantityAddEvent>(cartQuantityAddEvent);
    on<CartQuantityReduceEvent>(cartQuantityReduceEvent);
    on<CartParcelEvent>(cartParcelEvent);
    on<CartSelectedEvent>(cartSelectedEvent);
  }

  FutureOr<void> cartQuantityAddEvent(
      CartQuantityAddEvent event, Emitter<CartQuantityState> emit) {
    if (state is CartQuantityInitialState) {
      int current = (state as CartQuantityInitialState).quantity;
      bool parcel = (state as CartQuantityInitialState).parcel;
      bool isSelected = (state as CartQuantityInitialState).isSelected;
      if (current != 10) {
        emit(CartQuantityInitialState(current + 1, parcel, isSelected));
      }
    }
  }

  FutureOr<void> cartQuantityReduceEvent(
      CartQuantityReduceEvent event, Emitter<CartQuantityState> emit) {
    if (state is CartQuantityInitialState) {
      int current = (state as CartQuantityInitialState).quantity;
      bool parcel = (state as CartQuantityInitialState).parcel;
      bool isSelected = (state as CartQuantityInitialState).isSelected;
      if (current != 1) {
        emit(CartQuantityInitialState(current - 1, parcel, isSelected));
      }
    }
  }

  FutureOr<void> cartParcelEvent(
      CartParcelEvent event, Emitter<CartQuantityState> emit) {
    if (state is CartQuantityInitialState) {
      int current = (state as CartQuantityInitialState).quantity;
      bool parcel = (state as CartQuantityInitialState).parcel;
      bool isSelected = (state as CartQuantityInitialState).isSelected;

      emit(CartQuantityInitialState(current, !parcel, isSelected));
    }
  }

  FutureOr<void> cartSelectedEvent(
      CartSelectedEvent event, Emitter<CartQuantityState> emit) {
    if (state is CartQuantityInitialState) {
      int current = (state as CartQuantityInitialState).quantity;
      bool parcel = (state as CartQuantityInitialState).parcel;
      bool isSelected = (state as CartQuantityInitialState).isSelected;

      emit(CartQuantityInitialState(current, parcel, !isSelected));
    }
  }
}
