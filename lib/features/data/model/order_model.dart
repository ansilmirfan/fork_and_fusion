import 'package:fork_and_fusion/features/data/model/cart_model.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required super.id,
      required super.customerId,
      required super.paymentId,
      required super.amount,
      required super.date,
      required super.table,
      required super.products,
      super.status});
  factory OrderModel.fromMap(Map<String, dynamic> map, List<CartEntity> carts) {
    return OrderModel(
        id: map['id'] ?? '',
        table: map['table'] ?? '',
        customerId: map['customer id'] ?? '',
        paymentId: map['payment id'] ?? '',
        amount: map['amount'] ?? 0,
        date: DateTime.parse(map['date']),
        products: carts,
        status: map['status']);
  }
  static Map<String, dynamic> toMap(OrderEntity order) {
    return {
      'id': order.id,
      'customer id': order.customerId,
      'payment id': order.paymentId,
      'date': order.date.toString(),
      'amount': order.amount,
      'status': order.status,
      'table': order.table,
      'items': cartToListOfMap(order.products)
    };
  }

  static List<Map<String, dynamic>> cartToListOfMap(List<CartEntity> carts) {
    return carts.map((element) {
      return CartModel.toMapWhole(element);
    }).toList();
  }
}
