import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/filter_widget.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/filter_variables.dart';

filterBottomSheet(
    BuildContext context, FilterVariables variables, ProductBloc bloc) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return FilterWidget(
        varible: variables,
        bloc: bloc
      );
    },
  );
}
