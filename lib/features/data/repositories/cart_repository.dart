// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_authentication.dart';
import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_services.dart';
import 'package:fork_and_fusion/features/data/model/cart_model.dart';
import 'package:fork_and_fusion/features/data/model/category_model.dart';
import 'package:fork_and_fusion/features/data/model/product_model.dart';
import 'package:fork_and_fusion/features/data/repositories/firebase_auth_repository.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/cart_repo.dart';

class CartRepository extends CartRepo {
  FirebaseServices _dataSource = FirebaseServices();

  String collection = 'cart';
  String secondCollection = 'cart data';

  //-----------get all cart item-----------------
  @override
  Future<List<CartEntity>> getAll() async {
    FirebaseAuthRepository repo = Services.firebaseRepo();
    FireBaseAuthDataSource _auth = repo.dataSource;
    final user = await _auth.currentUser();
    //------getting list of reference of cart from the cart---------------
    final map = await _dataSource.getOne(collection, user!.uid);
    final List<String> cartIds = List<String>.from(map['cart ids'] ?? []);
    //--------------converting the cart id's to cart objects---------------
    Future<List<CartEntity>> data = Future.wait(cartIds.map((cartId) async {
      final cartMap = await _dataSource.getOne(secondCollection, cartId);
      String productId = cartMap['product'];
      final productMap = await _dataSource.getOne('products', productId);
      List<String> categoryIds = List<String>.from(productMap['category']);
      //----------------converting to category entity-------------

      List<CategoryEntity> categories =
          await Future.wait(categoryIds.map((categoryId) async {
        final category = await _dataSource.getOne('category', categoryId);

        return CategoryModel.fromMap(category);
      }));
      //---------------converting to product entity-----------------
      ProductEntity productEntity =
          ProductModel.fromMap(productMap, categories);
      //------------returning cart object-------------------
      return CartModel.fromMap(cartMap, productEntity);
    }));
   
    return data;
  }

  //-----------create cart-------------------------

  @override
  Future<bool> addToCart(CartEntity data) async {
    FirebaseAuthRepository repo = Services.firebaseRepo();
    FireBaseAuthDataSource _auth = repo.dataSource;
    final user = await _auth.currentUser();
    //----------checking for duplicates--------------
    log(user!.uid);
    List<CartEntity> allCartItems = await getAll();
    //----------getting all the id that matches the product,parcel status
    //--------and selected type if there is any variants----------
    var duplicates = allCartItems
        .where((e) =>
            e.product.id == data.product.id &&
            e.parcel == data.parcel &&
            e.selectedType == data.selectedType)
        .toList();
    if (duplicates.isNotEmpty) {
      throw 'Item is already in the cart';
    }

    String? id =
        await _dataSource.create(secondCollection, CartModel.toMap(data));
    if (id != null) {
      //------------if id is not null updating the list to the collection----------
      final cartMap = await _dataSource.getOne(collection, user.uid);
      List<String> cartIds = List<String>.from(cartMap['cart ids'] ?? []);
      cartIds.add(id);
      await _dataSource.edit(user.uid, collection, {'cart ids': cartIds});
      return true;
    }

    return false;
  }

  //-------------------delete cart---------------

  @override
  Future<bool> deleteCart(String id) async {
    FirebaseAuthRepository repo = Services.firebaseRepo();
    FireBaseAuthDataSource _auth = repo.dataSource;
    final user = await _auth.currentUser();
    final map = await _dataSource.getOne(collection, user!.uid);
    final List<String> cartIds = List<String>.from(map['cart ids'] ?? []);
    bool isDeleted = cartIds.remove(id);
    if (isDeleted) {
      await _dataSource.edit(user.uid, collection, {'cart ids': cartIds});
      await _dataSource.delete(id, secondCollection);
      return true;
    }
    return false;
  }

  @override
  Future<bool> checkForDuplicate(CartEntity data) async {
    final list = await getAll();
    return list
        .where((element) =>
            element.id != data.id &&
            element.product.id == data.product.id &&
            element.parcel == data.parcel &&
            data.selectedType == element.selectedType)
        .toList()
        .isNotEmpty;
  }

  //-------------edit cart---------------------

  @override
  Future<bool> updateCart(CartEntity newData) async {
    final duplicate = await checkForDuplicate(newData);
    if (duplicate) {
      return false;
    }
    log(newData.id);
    return await _dataSource.edit(
        newData.id, secondCollection, CartModel.toMap(newData));
  }

  //----------update few fields-----------
  @override
  Future<bool> updateFewFields(String id, Map<String, dynamic> data) async {
    return await _dataSource.edit(id, secondCollection, data);
  }
}
