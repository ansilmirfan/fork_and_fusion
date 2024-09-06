part of 'quantity_bloc.dart';

@immutable
sealed class QuantityState {}

final class QuantityInitialState extends QuantityState {
  int quantity;
  bool parcel = false;
  QuantityInitialState(this.quantity, this.parcel);
}
