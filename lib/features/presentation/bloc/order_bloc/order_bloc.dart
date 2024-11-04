import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/order_usecase/cancel_order_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/order_usecase/get_all_order_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/order_usecase/rate_order_usecase.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitialState()) {
    on<OrderGetAllEvent>(orderGetAllEvent);
    on<OrderCancelEvent>(orderCancelEvent);
    on<OrderRatingEvent>(orderRatingEvent);
  }

  FutureOr<void> orderGetAllEvent(
      OrderGetAllEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    GetAllOrderUsecase usecase = GetAllOrderUsecase(Services.orderRepository());
    await emit.forEach(
      usecase.call(),
      onData: (data) {
        data.sort((a, b) => b.date.compareTo(a.date));
        return OrderCompletedState(data);
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return OrderErrorState('Network error');
      },
    );
  }

  FutureOr<void> orderCancelEvent(
      OrderCancelEvent event, Emitter<OrderState> emit) async {
    emit(OrderCancelLoadingEvent());
    try {
      CancelOrderUsecase usecase =
          CancelOrderUsecase(Services.orderRepository());
      await usecase.call(event.order);
      add(OrderGetAllEvent());
    } catch (e) {
      emit(OrderErrorState('Network Error'));
    }
  }

  FutureOr<void> orderRatingEvent(
      OrderRatingEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    try {
      RateOrderUsecase usecase = RateOrderUsecase(Services.orderRepository());
      for (var element in event.order.products) {
        if (event.productId == element.product.id) {
          element.rated = true;
        }
      }
      await usecase.call(event.order, event.productId, event.rating);
      emit(OrderRatingCompletedState(event.productId));
      add(OrderGetAllEvent());
    } catch (e) {
      emit(OrderErrorState('Network Error'));
    }
  }
}
