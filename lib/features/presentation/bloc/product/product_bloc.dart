import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/data/repositories/product_repository.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/domain/repository/product_repo.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/product_usecases.dart';
import 'package:fork_and_fusion/features/domain/usecase/firebase_usecases/search_product_usecase.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<FeatchAllProducts>(featchAllProducts);
    on<SearchProductEvent>(searchProductEvent);
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
}
