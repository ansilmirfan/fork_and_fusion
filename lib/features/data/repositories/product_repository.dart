import 'dart:developer';

import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_services.dart';
import 'package:fork_and_fusion/features/data/model/category_model.dart';
import 'package:fork_and_fusion/features/data/model/product_model.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/product_repo.dart';

class ProductRepository implements ProductRepo {
  final FirebaseServices _dataSource = FirebaseServices();

  @override
  Stream<List<ProductEntity>> featchAllProducts() async* {
    final dataStream = _dataSource.featchAll('products');

    await for (final list in dataStream) {
      log('Data fetched from Firebase');

      // ------- fetched data to ProductEntity
      List<ProductEntity> products = await Future.wait(
        list.map((map) async {
          List<dynamic> categoryIds = map['category'] ?? [];
          List<CategoryEntity> categories = await Future.wait(
            categoryIds.map((categoryId) async {
              final data = await _dataSource.getOne('category', categoryId);
              return CategoryModel.fromMap(data);
            }),
          );

          log('Data converted to ProductEntity');
          return ProductModel.fromMap(map, categories);
        }),
      );

      yield products;
    }
  }

//-------------------search products------------
  @override
  Future<List<ProductEntity>> searchProducts(String querry) async {
    final list = await _dataSource.search('products', querry);
    List<Future<ProductEntity>> future = list.map((map) async {
      List c = map['category'];

      List<CategoryEntity> category = await Future.wait(c.map((e) async {
        final data = await _dataSource.getOne('category', e);
        return CategoryModel.fromMap(data);
      }));

      return ProductModel.fromMap(map, category);
    }).toList();

    return await Future.wait(future);
  }
}
