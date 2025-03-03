import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/core/utils/utils.dart';
import 'package:fork_and_fusion/features/domain/entity/cart_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/presentation/bloc/cart_managemnt/cart_management_bloc.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/cart/pages/payment_success.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/custom_eleavated_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custome_appbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/empty_message.dart';
import 'package:fork_and_fusion/features/presentation/widgets/overlay_loading.dart';
import 'package:fork_and_fusion/features/presentation/widgets/product_listtile/product_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/textbutton.dart';
import 'package:paypal_payment/paypal_payment.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  final gap = const SizedBox(height: 10);
  late CartManagementBloc cartBloc;

  String amount = "0";
  List<CartEntity> selected = [];

  @override
  Widget build(BuildContext context) {
    cartBloc = context.read<CartManagementBloc>();
    cartBloc.add(CartManagemntGetAllEvent());

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [CustomAppbar()],
        body: RefreshIndicator(
          onRefresh: () async => context
              .read<CartManagementBloc>()
              .add(CartManagemntGetAllEvent()),
          child: BlocConsumer<CartManagementBloc, CartManagementState>(
            buildWhen: (previous, current) {
              return current is CartManagementCompletedState ||
                  current is CartManagementNetWorkErrorState;
            },
            listener: (context, state) {
              if (state is CartManagementPoceedsToBuyState) {
                _navigateToPayment(context, state);
              } else if (state is CartManagementErrorState) {
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
                amount = state.subtotal.toString();
                selected = state.cart;
                return _buildBody(state, context);
              }

              return EmptyMessage(message: '');
            },
          ),
        ),
      ),
    );
  }

  void _navigateToPayment(
      BuildContext context, CartManagementPoceedsToBuyState state) {
    if (Constants.table.isEmpty) {
      showCustomSnackbar(
          context: context,
          message: "To order, simply scan the QR code at your table!",
          isSuccess: false);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PaypalOrderPayment(
                sandboxMode: true,
                clientId: state.clientId,
                secretKey: state.secretKey,
                amount: amount,
                currencyCode: "USD",
                returnURL: state.url,
                cancelURL: state.url,
                onSuccess: onSuccessCallback,
                onError: (error) {
                  log(error.toString());
                  showCustomSnackbar(
                      context: context,
                      message: "Transaction Failed",
                      isSuccess: false);
                },
                onCancel: onCancelCallback,
              )));
    }
  }

  Widget _buildBody(CartManagementCompletedState state, BuildContext context) {
    if (state.cart.isEmpty) {
      return EmptyMessage(
          message:
              'Your cart is empty! Add some delicious items to start your order.');
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildHeader(context, state),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: _listView(state.cart),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
      BuildContext context, CartManagementCompletedState state) {
    return Padding(
      padding: Constants.padding10,
      child: Column(
        children: [
          subtotalAndDeleteButton(context, state.cart, state.subtotal),
          gap,
          _buildProceedsToBuyButton(
              state.isSelected, state.selectedLength, context),
        ],
      ),
    );
  }

  Align subtotalAndDeleteButton(
      BuildContext context, List<CartEntity> data, int subtotal) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal: \u20B9 $subtotal ',
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

  Visibility _buildProceedsToBuyButton(
      bool isEmpty, int selectedLength, BuildContext context) {
    return Visibility(
      visible: isEmpty,
      child: CustomTextButton(
        text: 'Proceed to buy ($selectedLength item)',
        onPressed: () {
          if (kIsWeb) {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => PaymentSuccessPage(),
            ))
                .then((value) {
              String paymentId = Utils.generateUniquePaymentId();
              _placeOrder(paymentId);
            });
          } else {
            context
                .read<CartManagementBloc>()
                .add(CartManagementProceedToBuyEvent());
          }
        },
      ),
    );
  }

  List<Widget> _listView(List<CartEntity> data) {
    return data.map((element) {
      return SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ProductListTile(
            cart: element,
            type: ListType.cartView,
          ),
        ),
      );
    }).toList();
  }

  onSuccessCallback(value) {
    var paymentId = value['data']['id'];
    _placeOrder(paymentId);
  }

  void _placeOrder(paymentId) {
    cartBloc.add(CartManagementPlaceOrderEvent(
      OrderEntity(
          id: '',
          paymentId: paymentId,
          amount: num.tryParse(amount) ?? 0,
          products: selected,
          customerId: Constants.user?.userId ?? '',
          table: Constants.table,
          date: DateTime.now()),
    ));
  }

  onErrorCallback(error) {}

  onCancelCallback() {}
}
