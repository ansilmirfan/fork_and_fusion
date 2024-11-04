

import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_authentication.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_services.dart';
import 'package:fork_and_fusion/features/data/model/category_model.dart';
import 'package:fork_and_fusion/features/data/model/product_model.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/favourite_repo.dart';

class FavouriteRepository extends FavouriteRepo {
  final FirebaseServices _dataSource = FirebaseServices();
  final FireBaseAuthDataSource _auth = Services.firebaseRepo().dataSource;

  String collection = 'favourite';
  @override
  Future<bool> addToFavourite(String id) async {
    final user = await _auth.currentUser();
    var productId = <String>[];
    if (user != null) {
      var map = await _dataSource.getOne(collection, user.uid);
   
      productId = List<String>.from(map['favourite'] ?? []);
      if (productId.contains(id)) {
        throw 'Product is already in the favourite';
      }
      productId.add(id);
      await _dataSource.edit(user.uid, collection, {'favourite': productId});
    }
    return false;
  }

  @override
  Future<bool> removeFavourite(String id) async {
    final user = await _auth.currentUser();
    var productId = <String>[];
    if (user != null) {
      var map = await _dataSource.getOne(collection, user.uid);
      productId = List<String>.from(map['favourite'] ?? []);
      if (productId.contains(id)) {
        productId.remove(id);
      }

      await _dataSource.edit(user.uid, collection, {'favourite': productId});
    }
    return false;
  }

  @override
  Future<List<ProductEntity>> getAllFavourite() async {
    final user = await _auth.currentUser();

    var productId = <String>[];
    if (user != null) {
      var map = await _dataSource.getOne(collection, user.uid);
      productId = List<String>.from(map['favourite'] ?? []);
    }
    Future<List<ProductEntity>> future = Future.wait(productId.map((id) async {
      final productMap = await _dataSource.getOne('products', id);

      final categoryList = List<String>.from(productMap['category']);
      final categories = await Future.wait(categoryList.map((element) async {
        final category = await _dataSource.getOne('category', element);
        return CategoryModel.fromMap(category);
      }));
      return ProductModel.fromMap(productMap, categories);
    }));

    return future;
  }

  @override
  Future<bool> checkForFavourite(String productId) async {
    final favouriteList = await getAllFavourite();

    for (var element in favouriteList) {
      if (element.id == productId) {
        return true;
      }
    }
    return false;
  }
}
