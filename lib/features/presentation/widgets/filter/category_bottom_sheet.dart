import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_category_cubit/selected_category_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';

categoryBottomSheet(BuildContext context, List<ProductEntity> data) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (context) {
      return CategoryBottomSheetBody(
        data: data,
      );
    },
  );
}

class CategoryBottomSheetBody extends StatelessWidget {
  final List<ProductEntity> data;
  const CategoryBottomSheetBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>();
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      snap: true,
      builder: (context, scrollController) {
        return Padding(
          padding: Constants.padding10,
          child: Container(
            padding: Constants.padding10,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 238, 238),
              borderRadius: Constants.radius,
            ),
            child: _listview(scrollController, context, data),
          ),
        );
      },
    );
  }

  BlocBuilder<CategoryBloc, CategoryState> _listview(
      ScrollController scrollController,
      BuildContext context,
      List<ProductEntity> data) {
    final selectedCategoryState = context.read<SelectedCategoryCubit>().state;

    String selected = 'all';
    if (selectedCategoryState is SelectedCategoryChangedState) {
      selected = selectedCategoryState.category;
    }
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoryCompletedState) {
          return ListView.builder(
            itemCount: state.categories.length,
            controller: scrollController,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: Constants.radius,
                elevation: 10,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CacheImage(
                          url: state.categories[index].image,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(Utils.capitalizeEachWord(
                          state.categories[index].name)),
                    ],
                  ),
                  value: selected == state.categories[index].id,
                  onChanged: (value) {
                    context.read<SelectedCategoryCubit>().onSelectedCategory(
                        state.categories[index].id, index, data);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          );
        }
        if (state is CategoryErrorState) {
          return Center(child: Text(state.message));
        }
        return Constants.none;
      },
    );
  }
}
