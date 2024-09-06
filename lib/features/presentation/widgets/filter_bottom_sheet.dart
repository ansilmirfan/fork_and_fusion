import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/filter_widget.dart';

filterBottomSheet(BuildContext context, [bool category=false]){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return FilterWidget(category: category,);
    },
  );
}
