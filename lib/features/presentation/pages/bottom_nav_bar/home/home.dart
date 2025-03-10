import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_category_cubit/selected_category_cubit.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/carousal.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/category.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/custome_item_card.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/home/widgets/scanner_icon.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_appbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/empty_message.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';
import 'package:fork_and_fusion/features/presentation/widgets/loading.dart';
import 'package:fork_and_fusion/features/presentation/widgets/overlay_loading.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/product_listtile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    hideLoadingOverlay();

    context.read<SelectedCategoryCubit>();
    context.read<ProductBloc>();
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Loading();
          }
          if (state is ProductErrorState) {
            return EmptyMessage(message: state.message);
          }
          if (state is ProductCompletedState) {
            return _buildBody(context, state.data);
          }
          return ScannerIcon();
        },
      ),
    );
  }

  RefreshIndicator _buildBody(BuildContext context, List<ProductEntity> data) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductBloc>().add(FeatchAllProducts());
      },
      child: CustomScrollView(
        slivers: [
          CustomAppbar(scanner: true),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Carousal(data: data),
                  Gap(gap: 10),
                  _specialOfferCard(data),
                  Gap(gap: 10),
                  _seasonalFoodsCard(data),
                  Gap(gap: 10),
                  CategoryScrollView(products: data),
                  Gap(gap: 10),
                ],
              ),
            ),
          ),
          _buildListView(data),
        ],
      ),
    );
  }

  CustomItemCard _seasonalFoodsCard(List<ProductEntity> data) {
    return CustomItemCard(
      data: data,
      title: 'Seasonal foods',
      offer: false,
    );
  }

  CustomItemCard _specialOfferCard(List<ProductEntity> data) {
    return CustomItemCard(
      data: data,
      title: 'Special offers',
    );
  }

  BlocBuilder _buildListView(List<ProductEntity> data) {
    return BlocBuilder<SelectedCategoryCubit, SelectedCategoryState>(
      builder: (context, state) {
        if (state is SelectedCategoryInitialState) {
          return _listview(data);
        }
        if (state is SelectedCategoryChangedState) {
          return _listview(state.filtered);
        }
        return Constants.none;
      },
    );
  }

  _listview(List<ProductEntity> data) {
    if (data.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: Constants.dHeight * .25,
          child: const Center(
              child: Text(
            'No products available for this category.',
            textAlign: TextAlign.center,
          )),
        ),
      );
    }
    List<FavouriteBloc> favouriteBlocs =
        List.generate(data.length, (index) => FavouriteBloc());

    return SliverList.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ProductListTile(
          product: data[index],
          favouriteBloc: favouriteBlocs[index],
        ),
      ),
    );
  }
}
