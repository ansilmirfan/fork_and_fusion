import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/add_to_cart_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/cart_delete_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/cart_edit_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/cart_update_few_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/get_all_cart_usecase.dart';
import 'package:meta/meta.dart';

part 'cart_management_event.dart';
part 'cart_management_state.dart';

class CartManagementBloc
    extends Bloc<CartManagementEvent, CartManagementState> {
  CartManagementBloc() : super(CartManagementInitialState()) {
    on<CartManagementAddToCartEvent>(cartManagementAddToCartEvent);
    on<CartManagementCheckForDuplicate>(cartManagementCheckForDuplicate);
    on<CartManagemntGetAllEvent>(cartManagemntGetAllEvent);
    on<CartManagementUpdateQuantityEvent>(cartManagementUpdateQuantityEvent);
    on<CartManagementUpdateParcelStatusEvent>(
        cartManagementUpdateParcelStatusEvent);
    on<CartManagementSelectedEvent>(cartManagementSelectedEvent);
    on<CartManagementDeleteEvent>(cartManagementDeleteEvent);
    on<CartManagementEditEvent>(cartManagementEditEvent);
  }

  FutureOr<void> cartManagementAddToCartEvent(
      CartManagementAddToCartEvent event,
      Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState());
    try {
      AddToCartUsecase usecase = AddToCartUsecase(Services.cartRepo());
      await usecase.call(event.cart);

      emit(CartManagementAddedToCartState());
    } catch (e) {
      emit(CartManagementErrorState(e.toString()));
    }
  }

//--------------check for duplice-------------------
  FutureOr<void> cartManagementCheckForDuplicate(
      CartManagementCheckForDuplicate event,
      Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState());

    try {
      GetAllCartUsecase usecase = GetAllCartUsecase(Services.cartRepo());
      var data = await usecase.call();

      data = data
          .where((e) =>
              e.product.id == event.productId &&
              e.parcel == event.parcel &&
              e.selectedType == event.selectedVarinat)
          .toList();

      if (data.isEmpty) {
        emit(CartManagementItemNotInCartState());
      } else {
        emit(CartManagementGoToCartState());
      }
    } catch (e) {
      if (e is SocketException) {
        emit(CartManagementNetWorkErrorState());
      }
      emit(CartManagementErrorState(e.toString()));
    }
  }

  FutureOr<void> cartManagemntGetAllEvent(
      CartManagemntGetAllEvent event, Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState(fromAnother: event.fromEvent));

    try {
      GetAllCartUsecase usecase = GetAllCartUsecase(Services.cartRepo());
      final cartItems = await usecase.call();
      emit(CartManagementCompletedState(cartItems));
    } catch (e) {
      emit(CartManagementErrorState('NetWork error please try again'));
    }
  }

//-------------------quantity update -----------------------
  FutureOr<void> cartManagementUpdateQuantityEvent(
      CartManagementUpdateQuantityEvent event,
      Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState());
    try {
      CartUpdateFewUsecase usecase = CartUpdateFewUsecase(Services.cartRepo());

      if (event.increase) {
        if (event.cart.quantity == 10) {
          emit(CartManagementErrorState('Maximum limit reached'));
        } else {
          await usecase.call(
              event.cart.id, 'quantity', event.cart.quantity + 1);
        }
      } else {
        if (event.cart.quantity == 1) {
          emit(CartManagementErrorState('Minimum limit reached'));
        } else {
          await usecase.call(
              event.cart.id, 'quantity', event.cart.quantity - 1);
        }
      }
      add(CartManagemntGetAllEvent(fromEvent: true));
    } catch (e) {
      log(e.toString());
      emit(CartManagementErrorState('NetWork error please try again'));
    }
  }

//---------------------parcel status changing event-----------
  FutureOr<void> cartManagementUpdateParcelStatusEvent(
      CartManagementUpdateParcelStatusEvent event,
      Emitter<CartManagementState> emit) async {
    event.cart.parcel = !event.cart.parcel;
    log(event.cart.parcel.toString());
    emit(CartManagementLoadingState());

    try {
      CartEditUsecase usecase = CartEditUsecase(Services.cartRepo());
      final result = await usecase.call(event.cart);

      if (!result) {
        log(event.cart.parcel.toString());
        emit(CartManagementErrorState('Product is already in the cart'));
      }
      add(CartManagemntGetAllEvent());
    } catch (e) {
      event.cart.parcel = !event.cart.parcel;
      emit(CartManagementErrorState('Network error, please try again'));
    }
  }

//------------------selecting------------
  FutureOr<void> cartManagementSelectedEvent(CartManagementSelectedEvent event,
      Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState());
    try {
      CartUpdateFewUsecase usecase = CartUpdateFewUsecase(Services.cartRepo());
      await usecase.call(event.cart.id, 'selected', !event.cart.isSelected);
      add(CartManagemntGetAllEvent());
    } catch (e) {
      emit(CartManagementErrorState('Network error, please try again'));
    }
  }

  FutureOr<void> cartManagementDeleteEvent(CartManagementDeleteEvent event,
      Emitter<CartManagementState> emit) async {
    try {
      CartDeleteUsecase usecase = CartDeleteUsecase(Services.cartRepo());
      for (var element in event.data) {
        if (element.isSelected) {
          await usecase.call(element.id);
        }
      }
      add(CartManagemntGetAllEvent());
    } catch (e) {
      emit(CartManagementErrorState('Network error, please try again'));
    }
  }

  FutureOr<void> cartManagementEditEvent(
      CartManagementEditEvent event, Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState());
    try {
      CartEditUsecase usecase = CartEditUsecase(Services.cartRepo());
      final result = await usecase.call(event.newData);
      if (!result) {
        emit(CartManagementErrorState('Product is already in the cart'));
      } else {
        emit(CartManagementEditedState());
      }

      add(CartManagemntGetAllEvent());
    } catch (e) {
      log(e.toString());
      emit(CartManagementErrorState('Network error, please try again'));
    }
  }
}
