import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/favourite/favourite_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/favourite_get_all/favourite_get_all_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/empty_message.dart';
import 'package:fork_and_fusion/features/presentation/widgets/loading.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/product_listtile.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavouriteGetAllCubit>().getAll();
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FavouriteGetAllCubit>().getAll();
        },
        child: Padding(
          padding: Constants.padding10,
          child: BlocBuilder<FavouriteGetAllCubit, FavouriteGetAllState>(
            builder: (context, state) {
              if (state is FavouriteGetAllLoadingState) {
                return const Loading();
              }
              if (state is FavouriteGetAllCompletedState) {
                if (state.favourites.isEmpty) {
                  return EmptyMessage(
                      message:
                          "Oops, your favorites list is empty. Time to fill it up!");
                }
                return _listView(state.favourites);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  ListView _listView(List<ProductEntity> favourite) {
    List<FavouriteBloc> blocs =
        List.generate(favourite.length, (index) => FavouriteBloc());
    return ListView.builder(
      itemCount: favourite.length,
      itemBuilder: (context, index) => ProductListTile(
        product: favourite[index],
        favouriteBloc: blocs[index],
        fromFavourite: true,
      ),
    );
  }
}
