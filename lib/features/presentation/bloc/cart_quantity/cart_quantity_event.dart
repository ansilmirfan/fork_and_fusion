part of 'cart_quantity_bloc.dart';

@immutable
sealed class CartQuantityEvent {}

class CartQuantityAddEvent extends CartQuantityEvent {}

class CartQuantityReduceEvent extends CartQuantityEvent {}

class CartParcelEvent extends CartQuantityEvent {}

class CartSelectedEvent extends CartQuantityEvent {

}
