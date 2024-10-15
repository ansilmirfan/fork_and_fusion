// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';

class DismissibleProductTile extends StatefulWidget {
  final Widget child;
  final String id;

  const DismissibleProductTile(
      {super.key, required this.child, required this.id});

  @override
  _DismissibleProductTileState createState() => _DismissibleProductTileState();
}

class _DismissibleProductTileState extends State<DismissibleProductTile> {
  double dragExtent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('dismissible_item'),
      background: Builder(
        builder: (context) {
          double progress = (dragExtent / Constants.dWidth) / 2;

          return Container(
            color: Theme.of(context).colorScheme.error,
            child: Align(
              alignment: Alignment(1 - (progress * 2), 0),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.tertiary,
                size: 30,
              ),
            ),
          );
        },
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        context
            .read<CartManagementBloc>()
            .add(CartManagementDeleteOneEvent(widget.id));
        return false;
      },
      onUpdate: (details) {
        setState(() {
          dragExtent = details.progress * Constants.dWidth;
        });
      },
      child: widget.child,
    );
  }
}
