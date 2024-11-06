import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/add_to_cart_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/cart_delete_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/cart_edit_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/cart_update_few_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/cart_usecase/get_all_cart_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/order_usecase/place_order_usecase.dart';
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
    on<CartManagementDeleteOneEvent>(cartManagementDeleteOneEvent);
    on<CartManagementProceedToBuyEvent>(cartManagementProceedToBuyEvent);
    on<CartManagementPlaceOrderEvent>(cartManagementPlaceOrderEvent);
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
    emit(CartManagementLoadingState());

    try {
      GetAllCartUsecase usecase = GetAllCartUsecase(Services.cartRepo());
      final cartItems = await usecase.call();
//----------checking for selected items-------------
      bool isSelected = cartItems.any((element) => element.isSelected);
      //------------selected item count-----------------------
      int len = cartItems.where((e) => e.isSelected).length;
      //-----------total amount if the user selects the items then the
      //--------subtotal is the sum of selected items otherwise the sum of all amount
      int subtotal = 0;
      if (cartItems.isNotEmpty) {
        if (isSelected) {
          subtotal = cartItems
              .where((e) => e.isSelected)
              .map((e) =>
                  Utils.calculateOffer(e.product, e.selectedType) * e.quantity)
              .reduce((a, b) => a + b);
        } else {
          subtotal = cartItems
              .map((e) =>
                  Utils.calculateOffer(e.product, e.selectedType) * e.quantity)
              .reduce((a, b) => a + b);
        }
      }

      emit(CartManagementCompletedState(cartItems, isSelected, len, subtotal));
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
        await usecase.call(event.cart.id, 'quantity', event.cart.quantity + 1);
      } else {
        if (event.cart.quantity == 1) {
          add(CartManagementDeleteOneEvent(event.cart.id));
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
    try {
      if (!event.cart.product.type.contains(ProductType.todays_list)) {
        emit(CartManagementErrorState(
            'Sorry, this item is unavailable for today. Please choose another option or check back tomorrow.'));
      } else {
        emit(CartManagementLoadingState());
        CartUpdateFewUsecase usecase =
            CartUpdateFewUsecase(Services.cartRepo());
        await usecase.call(event.cart.id, 'selected', !event.cart.isSelected);
        add(CartManagemntGetAllEvent());
      }
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

  FutureOr<void> cartManagementDeleteOneEvent(
      CartManagementDeleteOneEvent event,
      Emitter<CartManagementState> emit) async {
    emit(CartManagementLoadingState());
    try {
      CartDeleteUsecase usecase = CartDeleteUsecase(Services.cartRepo());
      await usecase.call(event.id);
      add(CartManagemntGetAllEvent());
    } catch (e) {
      emit(CartManagementErrorState('Network error, please try again'));
    }
  }

  FutureOr<void> cartManagementProceedToBuyEvent(
      CartManagementProceedToBuyEvent event,
      Emitter<CartManagementState> emit) {
    String url = 'https:somrthing/shsf.com';
    String clientId = dotenv.env['CLIENT_ID'] ?? '';
    String secretId = dotenv.env['SECRET_ID'] ?? '';
    emit(CartManagementPoceedsToBuyState(
        clientId: clientId, secretKey: secretId, url: url));
  }

  FutureOr<void> cartManagementPlaceOrderEvent(
      CartManagementPlaceOrderEvent event,
      Emitter<CartManagementState> emit) async {
    try {
      event.order.products =
          event.order.products.where((e) => e.isSelected).toList();
      PlaceOrderUsecase usecase = PlaceOrderUsecase(Services.orderRepository());
      await usecase.call(event.order);
      log(event.order.products.toString());
      add(CartManagementDeleteEvent(event.order.products));
    } catch (e) {
      emit(CartManagementErrorState('Network error, please try again'));
    }
  }
}
