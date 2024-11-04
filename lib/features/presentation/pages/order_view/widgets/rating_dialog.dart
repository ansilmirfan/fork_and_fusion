import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/order_bloc/order_bloc.dart';

ratingDialog(BuildContext context, CartEntity cart, OrderEntity order) async {
  context.read<OrderBloc>();

  int rating = -1;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rate this Dish'),
        content: const Text('How would you rate this dish?'),
        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ratingStars(setState, rating, (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  }),
                  const Divider(),
                  Row(
                    children: [
                      const Spacer(),
                      _cancelButton(context),
                      _submitButton(context, order, rating + 1, cart),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      );
    },
  );
}

Row _ratingStars(
    StateSetter setState, int sIndex, Function(int) onRatingUpdate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      5,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            sIndex = index;
          });
          onRatingUpdate(index);
        },
        child: Icon(
          sIndex >= index ? Icons.star : Icons.star_border,
          color: sIndex >= index ? Colors.amber : Colors.black,
          size: 30,
        ),
      ),
    ),
  );
}

BlocConsumer _submitButton(
  BuildContext context,
  OrderEntity order,
  int rating,
  CartEntity cart,
) {
  return BlocConsumer<OrderBloc, OrderState>(
    listener: (context, state) {
      if (state is OrderRatingCompletedState) {
        Navigator.of(context).pop();
      }
    },
    builder: (context, state) {
      if (state is OrderLoadingState) {
        return TextButton(
          onPressed: () {},
          child: CircularProgressIndicator(strokeWidth: 2,),
        );
      }
      return TextButton(
        onPressed: () {
          context
              .read<OrderBloc>()
              .add(OrderRatingEvent(order, rating, cart.product.id));
        },
        child: const Text('Submit'),
      );
    },
  );
}

TextButton _cancelButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text('Cancel'),
  );
}
