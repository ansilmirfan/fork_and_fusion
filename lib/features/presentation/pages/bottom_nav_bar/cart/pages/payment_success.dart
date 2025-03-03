import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/custom_eleavated_button.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _icon(),
              Gap(gap: 20),
              _paymentSuccessText(),
              Gap(gap: 10),
              _descriptionText(),
              Gap(gap: 40),
              _popButton(context),
            ],
          ),
        ),
      ),
    );
  }

  CustomEleavatedButton _popButton(BuildContext context) {
    return CustomEleavatedButton(
      text: 'Back to Cart',
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Text _descriptionText() {
    return Text(
      'Thank you for your payment. Your transaction was successful.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }

  Text _paymentSuccessText() {
    return Text(
      'Payment Successful!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Icon _icon() {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 100,
    );
  }
}
