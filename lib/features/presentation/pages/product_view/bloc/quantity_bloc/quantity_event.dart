part of 'quantity_bloc.dart';

@immutable
sealed class QuantityEvent {}

class QuantityAddEvent extends QuantityEvent {}

class QuantityReduceEvent extends QuantityEvent {}

class ParcelEvent extends QuantityEvent {}
