import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/custom_eleavated_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_appbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/overlay_loading.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/prodct_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});
  final gap = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    context.read<CartManagementBloc>().add(CartManagemntGetAllEvent());

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [CustomAppbar()],
        body: BlocConsumer<CartManagementBloc, CartManagementState>(
          buildWhen: (previous, current) {
            return current is CartManagementCompletedState ||
                current is CartManagementNetWorkErrorState;
          },
          listener: (context, state) {
            if (state is CartManagementErrorState) {
              showCustomSnackbar(
                  context: context, message: state.message, isSuccess: false);
            } else if (state is CartManagementLoadingState) {
              showLoadingOverlay(context);
            } else {
              hideLoadingOverlay();
            }
          },
          builder: (context, state) {
            if (state is CartManagementCompletedState) {
              return _buildBody(state.cart, context);
            } else if (state is CartManagementNetWorkErrorState) {
              return _centerText('Network Error');
            }
            return _centerText('');
          },
        ),
      ),
    );
  }

  Widget _buildBody(List<CartEntity> data, BuildContext context) {
    if (data.isEmpty) {
      return _centerText(
          'Your cart is empty! Add some delicious items to start your order.');
    }

    return SingleChildScrollView(
      child: Column(
        children: [_buildHeader(context, data), ..._listView(data)],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, List<CartEntity> data) {
    return Padding(
      padding: Constants.padding10,
      child: Column(
        children: [
          subtotalAndDeleteButton(context, data),
          gap,
          _buildProceedsToBuyButton(data),
        ],
      ),
    );
  }

  Align subtotalAndDeleteButton(BuildContext context, List<CartEntity> data) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal: \u20B9 ${calculateSubtotal(data)} ',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Visibility(
            visible: data.where((e) => e.isSelected).isNotEmpty,
            child: CustomEleavatedButton(
              text: 'Delete',
              onPressed: () => context
                  .read<CartManagementBloc>()
                  .add(CartManagementDeleteEvent(data)),
            ),
          ),
        ],
      ),
    );
  }

  int calculateSubtotal(List<CartEntity> data) {
    if (data.isEmpty) {
      return 0;
    }
    //----------selected subtotal--------------
    final filtered = data.where((e) => e.isSelected).toList();
    if (filtered.isNotEmpty) {
      return filtered
          .map((e) =>
              Utils.calculateOffer(e.product, e.selectedType) * e.quantity)
          .reduce((a, b) => a + b);
    }
    //-----------whole subtotal------
    final total = data
        .map(
            (e) => Utils.calculateOffer(e.product, e.selectedType) * e.quantity)
        .reduce((a, b) => a + b);

    return total;
  }

  Visibility _buildProceedsToBuyButton(List<CartEntity> data) {
    final filtered = data.where((e) => e.isSelected).toList();

    return Visibility(
      visible: filtered.isNotEmpty,
      child: CustomTextButton(
        text: 'Proceed to buy (${filtered.length} item)',
        onPressed: () {},
      ),
    );
  }

  List<Widget> _listView(List<CartEntity> data) {
    return data.map((element) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ProductListTile(
          cart: element,
          type: ListType.cartView,
        ),
      );
    }).toList();
  }

  Widget _centerText(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
