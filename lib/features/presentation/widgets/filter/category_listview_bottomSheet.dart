import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/presentation/cubit/muti_selectable_cubit/multi_selectable_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';

import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

showCategoryListViewBottomSheet(
    MultiSelectableCubit cubit, BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        snap: true,
        builder: (context, scrollController) {
          return Padding(
            padding: Constants.padding10,
            child: Container(
              padding: Constants.padding10,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 239, 239),
                borderRadius: Constants.radius,
              ),
              child: _buildListView(cubit, scrollController),
            ),
          );
        },
      );
    },
  );
}

BlocBuilder<MultiSelectableCubit, MultiSelectableState> _buildListView(
    MultiSelectableCubit cubit, ScrollController scrollController) {
  return BlocBuilder<MultiSelectableCubit, MultiSelectableState>(
    bloc: cubit,
    builder: (context, state) {
      if (state is MultiSelectableLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is MultiSelectableCompletedState) {
        return listView(state.categories, scrollController, context, cubit,
            state.selectAll);
      }
      return const Center(
        child: Text('Please check the Internet'),
      );
    },
  );
}

Column listView(List<CategoryEntity> data, ScrollController scrollController,
        BuildContext context, MultiSelectableCubit cubit, bool selectAll) =>
    Column(
      children: [
        _buildSelectedCountAndpopButton(data, context),
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: Constants.padding10,
                    child: Material(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: Constants.radius,
                      elevation: 10,
                      child: CheckboxListTile(
                        selectedTileColor:
                            Theme.of(context).secondaryHeaderColor,
                        title: const Text('Select All'),
                        value: selectAll,
                        onChanged: (value) {
                          cubit.selectAllCategoty();
                        },
                      ),
                    ),
                  );
                }
                return _buildListTile(
                    data[index - 1], index - 1, context, cubit);
              }),
        ),
        CustomTextButton(
          text: 'Submit',
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );

Row _buildSelectedCountAndpopButton(
    List<CategoryEntity> data, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "    ${selectedCount(data)}  Selected",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close))
    ],
  );
}

String selectedCount(List<CategoryEntity> data) {
  if (data.isEmpty) {
    return '0';
  }
  return data.where((e) => e.selected).length.toString();
}

Padding _buildListTile(
  CategoryEntity data,
  int index,
  BuildContext context,
  MultiSelectableCubit cubit,
) {
  return Padding(
    padding: Constants.padding10,
    child: Material(
      color: Theme.of(context).colorScheme.tertiary,
      borderRadius: Constants.radius,
      elevation: 10,
      child: CheckboxListTile(
        selectedTileColor: Theme.of(context).secondaryHeaderColor,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CacheImage(
                width: 40,
                url: data.image,
              ),
            ),
            const SizedBox(width: 10),
            Text(Utils.capitalizeEachWord(data.name)),
          ],
        ),
        value: data.selected,
        onChanged: (value) {
          cubit.updateSelectedField(index);
        },
      ),
    ),
  );
}
