import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/cubit/muti_selectable_cubit/multi_selectable_cubit.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter/other/functions.dart';


class FilterVariables {
  FilterStates nameState = FilterStates.initial;
  FilterStates priceState = FilterStates.initial;
  RangeValues rangeValues = const RangeValues(20, 1200);
  MultiSelectableCubit cubit = MultiSelectableCubit();
}
