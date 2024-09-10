import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/ingrediants.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/quantity.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/widgets/rating.dart';
import 'package:fork_and_fusion/features/presentation/widgets/cache_image.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_textform_field.dart';
import 'package:fork_and_fusion/features/presentation/widgets/textbutton.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    var gap = const SizedBox(
      height: 10,
    );
    return BlocProvider(
      create: (context) => QuantityBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: Constants.dHeight * 2 / 5,
                child: const CacheImage(),
              ),
              _buildBody(context, gap),
              SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildBody(BuildContext context, SizedBox gap) {
    TextEditingController controller = TextEditingController();
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: Constants.dHeight * 3 / 5 + 40,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 252, 252),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dish name',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '₹250',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              gap,
              Ingrediants(gap: gap),
              gap,
              Rating(rating: 4),
              gap,
              Material(
                elevation: 10,
                borderRadius: Constants.radius,
                color: Theme.of(context).colorScheme.tertiary,
                child: Container(
                  width: double.infinity,
                  padding: Constants.padding10,
                  child: Column(
                    children: [
                      const Text('Add a cooking Request (optional)'),
                      gap,
                      CustomeTextField(
                        hintText: "e.g.Don't make it too spicy",
                        doubleLine: true,
                        controller: controller,
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Expanded(
                    child: Quantity(),
                  ),
                  Expanded(
                    child: BlocBuilder<QuantityBloc, QuantityState>(
                      builder: (context, state) {
                        if (state is QuantityInitialState) {
                          return ChoiceChip(
                            label: const Text('Parcel'),
                            selected: state.parcel,
                            onSelected: (value) {
                              context.read<QuantityBloc>().add(ParcelEvent());
                            },
                          );
                        }
                        return Constants.none;
                      },
                    ),
                  ),
                ],
              ),
              gap,
              CustomeTextButton(
                text: 'Add to Cart',
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
