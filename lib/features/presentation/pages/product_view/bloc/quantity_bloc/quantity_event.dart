part of 'quantity_bloc.dart';

@immutable
sealed class QuantityEvent {}

class QuantityInitialEvent extends QuantityEvent {
  int quantity;
  bool parcel;
  QuantityInitialEvent(this.quantity, this.parcel);
}

class QuantityAddEvent extends QuantityEvent {}

class QuantityReduceEvent extends QuantityEvent {}

class ParcelEvent extends QuantityEvent {}

class QuantityResetEvent extends QuantityEvent {}
