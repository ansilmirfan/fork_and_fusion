import 'dart:developer';

import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_authentication.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_services.dart';
import 'package:fork_and_fusion/features/data/model/cart_model.dart';
import 'package:fork_and_fusion/features/data/model/category_model.dart';
import 'package:fork_and_fusion/features/data/model/order_model.dart';
import 'package:fork_and_fusion/features/data/model/product_model.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/order_repo.dart';

class OrderRepository extends OrderRepo {
  final FirebaseServices _dataSource = FirebaseServices();
  final FireBaseAuthDataSource _authDataSource =
      Services.firebaseRepo().dataSource;
  final String collection = 'orders';
  @override
  Stream<List<OrderEntity>> getAllOrders() async* {
    final user = await _authDataSource.currentUser();
    final dataStream =
        _dataSource.featchAll(collection, 'customer id', user?.uid);

    await for (var snapshot in dataStream) {
      List<OrderEntity> orders = snapshot.map((map) {
        final items = List<Map<String, dynamic>>.from(map['items'] ?? []);

        List<CartEntity> carts = items.map((cartMap) {
          final Map<String, dynamic> productMap = cartMap['product']['product'];

          final List<Map<String, dynamic>> categoryMaps =
              List<Map<String, dynamic>>.from(
                  cartMap['product']['categories'] ?? []);

          List<CategoryEntity> categories = categoryMaps
              .map((element) => CategoryModel.fromMap(element))
              .toList();
          ProductEntity product = ProductModel.fromMap(productMap, categories);

          return CartModel.fromMap(cartMap, product);
        }).toList();

        return OrderModel.fromMap(map, carts);
      }).toList();

      yield orders;
    }
  }

  @override
  Future<void> placeOrder(OrderEntity order) async {
    final map = OrderModel.toMap(order);
    await _dataSource.create(collection, map);
  }
}
