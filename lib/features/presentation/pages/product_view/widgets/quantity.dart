import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/elevated_container.dart';

class Quantity extends StatelessWidget {
  QuantityBloc bloc;
  Quantity({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuantityBloc, QuantityState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is QuantityInitialState) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _squareButton(false, () => bloc.add(QuantityReduceEvent())),
              ElevatedContainer(
                child: Container(
                  height: 40,
                  width: 40,
                  padding: Constants.padding10,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      state.quantity.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              _squareButton(true, () => bloc.add(QuantityAddEvent()))
            ],
          );
        }
        return Constants.none;
      },
    );
  }

  SquareIconButton _squareButton(bool add, void Function()? onTap) {
    return SquareIconButton(
      white: false,
      icon: add ? Icons.add : Icons.remove,
      onTap: onTap,
    );
  }
}
