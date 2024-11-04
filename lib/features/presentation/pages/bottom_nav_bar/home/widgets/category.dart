import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:fork_and_fusion/features/presentation/cubit/selected_category_cubit/selected_category_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/category_bottom_sheet.dart';

class CategoryScrollView extends StatelessWidget {
  List<ProductEntity> products;
  CategoryScrollView({super.key, required this.products});
  CarouselController controller = CarouselController();
  bool isSelected = false;
  double width = Constants.dWidth;
  @override
  Widget build(BuildContext context) {
    context.read<SelectedCategoryCubit>();
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryCompletedState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Category'), _moreButton(context)],
              ),
              _categoriesScrollView(context, state.categories),
            ],
          );
        }
        if (state is CategoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Constants.none;
      },
    );
  }

  SizedBox _categoriesScrollView(
      BuildContext context, List<CategoryEntity> category) {
    return SizedBox(
      height: width * .20,
      child: BlocConsumer<SelectedCategoryCubit, SelectedCategoryState>(
        listener: (context, state) {
          if (state is SelectedCategoryChangedState) {
            //---------keeping selected item always on the middle-------------
            //-------- (item width * selected index)-itemwidth/2-------------
            double offeset = ((width * .2) * state.index) - (width * .1);
            controller.animateTo(offeset,
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut);
          }
        },
        builder: (context, state) {
          String selected = '';
          if (state is SelectedCategoryInitialState) {
            selected = state.category;
          }
          if (state is SelectedCategoryChangedState) {
            selected = state.category;
          }
          return CarouselView(
            controller: controller,
            onTap: (value) {
              if (value == 0) {
                context
                    .read<SelectedCategoryCubit>()
                    .onSelectedCategory('all', 0, products);
              } else {
                context
                    .read<SelectedCategoryCubit>()
                    .onSelectedCategory(category[value - 1].id, value - 1, products);
              }
            },
            itemExtent: width * .2,
            children: [
              //-------if the selected category is all selected area color will be diferrent
              DecoratedBox(
                decoration: BoxDecoration(
                  color: selected == 'all'
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                      : null,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: width * .07,
                      child: const Text('All'),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                category.length,
                (index) => _categoryWidget(context, category[index], selected),
              )
            ],
          );
        },
      ),
    );
  }

  Material _categoryWidget(
      BuildContext context, CategoryEntity category, String selected) {
    return Material(
      shape: const CircleBorder(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected == category.id
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
              : null,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CacheImage(url: category.image),
                ),
              ),
            ),
            SizedBox(
              width: width * .14,
              child: Text(
                Utils.capitalizeEachWord(category.name),
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton _moreButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        categoryBottomSheet(context,products);
      },
      child: const Text('more..'),
    );
  }
}
