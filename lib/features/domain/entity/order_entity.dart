import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';

class OrderEntity {
  String id;
  String paymentId;
  num amount;
  List<CartEntity> products;
  String status;
  DateTime date;
  String table;
  String customerId;
  OrderEntity(
      {required this.id,
      required this.paymentId,
      required this.amount,
      required this.products,
      required this.customerId,
      required this.table,
      required this.date,
      this.status = 'processing'});
}
