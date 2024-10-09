import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/data/repositories/product_repository.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/product_repo.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/product_usecases.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/search_product_usecase.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/functions.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<FeatchAllProducts>(featchAllProducts);
    on<SearchProductEvent>(searchProductEvent);
    on<ProductFilterEvent>(productFilterEvent);
  }

  FutureOr<void> featchAllProducts(
      FeatchAllProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    ProductRepo repo = ProductRepository();
    ProductUsecases productUsecases = ProductUsecases(repo);

    await emit.forEach<List<ProductEntity>>(
      productUsecases.call(),
      onData: (products) {
        //--------------only the data in today's list is showing------------
        products = products
            .where((e) => e.type.contains(ProductType.todays_list))
            .toList();
        return ProductCompletedState(products);
      },
      onError: (error, stackTrace) {
        return ProductErrorState(error.toString());
      },
    );
  }

  FutureOr<void> searchProductEvent(
      SearchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      ProductRepo repo = ProductRepository();
      SearchProductUsecase usecase = SearchProductUsecase(repo);
      final data = await usecase.call(event.querry);
      emit(ProductCompletedState(data));
    } catch (e) {
      emit(ProductErrorState('Network error please try again later'));
    }
  }

  FutureOr<void> productFilterEvent(
      ProductFilterEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    ProductRepo repo = ProductRepository();
    ProductUsecases productUsecases = ProductUsecases(repo);

    await emit.forEach<List<ProductEntity>>(
      productUsecases.call(),
      onData: (data) {
        //--------------only the data in today's list is showing------------
        data = data
            .where((e) => e.type.contains(ProductType.todays_list))
            .toList();
        //--------filter by category-----------
        data = data.where((e) {
          var selectedCategory = event.selectedCategory.map((e) => e.id);
          return e.category.any((e) => selectedCategory.contains(e.id));
        }).toList();

        //----------filter by price range-----------
        data = data.where((e) {
          num price =
              e.price == 0 ? _extractMin(e.variants.values.toList()) : e.price;

          return price >= event.rangeValues.start.toInt() &&
              price < event.rangeValues.end.toInt();
        }).toList();
        log('name state ${event.nameState}');
        log('price state ${event.priceState}');
        //-----------filter by name-----------
        if (event.nameState == FilterStates.asc) {
          data.sort((a, b) => a.name.compareTo(b.name));
        } else if (event.nameState == FilterStates.dsc) {
          data.sort((a, b) => b.name.compareTo(a.name));
        }
        //---------filter by price------------
        if (event.priceState == FilterStates.asc) {
          data = sortByPrice(data, true);
        } else if (event.priceState == FilterStates.dsc) {
          data = sortByPrice(data, false);
        }
        if (data.isEmpty) {
          return ProductNoDataOnFilterState();
        } else {
          return ProductCompletedState(data);
        }
      },
      onError: (error, stackTrace) {
        return ProductErrorState(error.toString());
      },
    );
  }
}

num _extractMin(List<dynamic> data) {
  return data
      .map((e) => e is String ? int.parse(e) : e)
      .toList()
      .reduce((a, b) => a < b ? a : b);
}

List<ProductEntity> sortByPrice(List<ProductEntity> data, bool isAsc) {
  data.sort((a, b) {
    num pa = a.price == 0
        ? a.variants.values
            .map((e) => e is String ? int.parse(e) : e)
            .toList()
            .reduce((a, b) => a < b ? a : b)
        : a.price;
    num pb = b.price == 0
        ? b.variants.values
            .map((e) => e is String ? int.parse(e) : e)
            .toList()
            .reduce((a, b) => a < b ? a : b)
        : b.price;
    return pa.compareTo(pb);
  });
  if (isAsc) {
    return data;
  }
  return data.reversed.toList();
}
