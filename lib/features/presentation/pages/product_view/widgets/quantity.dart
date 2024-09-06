import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

class Quantity extends StatelessWidget {
  const Quantity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuantityBloc, QuantityState>(
      builder: (context, state) {
        if (state is QuantityInitialState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareIconButton(
                icon: Icons.remove,
                onTap: () {
                  context.read<QuantityBloc>().add(QuantityReduceEvent());
                },
              ),
              Material(
                borderRadius: Constants.radius,
                color: Theme.of(context).colorScheme.tertiary,
                elevation: 10,
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.quantity.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SquareIconButton(
                icon: Icons.add,
                onTap: () {
                  context.read<QuantityBloc>().add(QuantityAddEvent());
                },
              ),
            ],
          );
        }
        return Constants.none;
      },
    );
  }
}
