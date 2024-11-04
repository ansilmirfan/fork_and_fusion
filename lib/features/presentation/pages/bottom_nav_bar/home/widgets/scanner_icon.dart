// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';

import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class ScannerIcon extends StatelessWidget {
  ScannerIcon({super.key});
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _scannerIcon(context),
          const SizedBox(height: 10),
          const Text(
            'Ready to order Tap the scanner icon \nto view our menu',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Material _scannerIcon(BuildContext context) {
    return Material(
      elevation: 10,
      color: Theme.of(context).colorScheme.tertiary,
      borderRadius: Constants.radius,
      child: InkWell(
        borderRadius: Constants.radius,
        onTap: () {
          _navigation(context);
        },
        child: SizedBox(
          height: Constants.dWidth * .4,
          width: Constants.dWidth * .4,
          child: const FittedBox(child: Icon(Icons.qr_code_scanner_outlined)),
        ),
      ),
    );
  }

  void _navigation(BuildContext context) {if (kIsWeb) {
      _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
          context: context,
          onCode: (code) {
            if (code != null) {
              if (!code.contains('Fork and Fusion')) {
                showCustomSnackbar(
                    context: context,
                    message:
                        'Looks like you scanned a QR code that doesn’t belong to our restaurant. Please scan the QR code at your table to view the menu',
                    isSuccess: false);
              }
              Constants.table = code;
              context.read<ProductBloc>().add(FeatchAllProducts());
            }
          });
    } else {
      Navigator.of(context).pushNamed('/qrscanner').then((value) {
        if (value is String && !value.contains('Fork and Fusion')) {
          showCustomSnackbar(
              context: context,
              message:
                  'Looks like you scanned a QR code that doesn’t belong to our restaurant. Please scan the QR code at your table to view the menu',
              isSuccess: false);
        } else {
          if (value is String) {
            Constants.table = value.split('_').sublist(1).join(' ');
            context.read<ProductBloc>().add(FeatchAllProducts());
          }
        }
      });
    }
    
  }
}
