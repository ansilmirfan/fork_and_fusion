import 'package:flutter/material.dart';

class FilterUtils {
  static FilterStates getNextState(FilterStates state) {
    switch (state) {
      case FilterStates.initial:
        return FilterStates.asc;
      case FilterStates.asc:
        return FilterStates.dsc;
      case FilterStates.dsc:
        return FilterStates.initial;
      default:
        return FilterStates.initial;
    }
  }

  static Icon getIcon(FilterStates state) {
    switch (state) {
      case FilterStates.asc:
        return const Icon(Icons.arrow_upward_rounded);
      case FilterStates.dsc:
        return const Icon(Icons.arrow_downward_rounded);
      default:
        return const Icon(Icons.unfold_more_rounded);
    }
  }
}

enum FilterStates { initial, asc, dsc }
