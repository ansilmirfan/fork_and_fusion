import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/order_usecase/get_all_order_usecase.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitialState()) {
    on<OrderGetAllEvent>(orderGetAllEvent);
  }

  FutureOr<void> orderGetAllEvent(
      OrderGetAllEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    GetAllOrderUsecase usecase = GetAllOrderUsecase(Services.orderRepository());
    await emit.forEach(
      usecase.call(),
      onData: (data) => OrderCompletedState(data),
      onError: (error, stackTrace) {
        log(error.toString());
        return OrderErrorState('Network error');
      },
    );
  }
}
