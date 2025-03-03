// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custom_circle_avathar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/gap.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';
// import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class CustomAppbar extends StatelessWidget {
  Widget? bottom;
  bool scanner;
  CustomAppbar({super.key, this.bottom, this.scanner = false});
  // final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  @override
  Widget build(BuildContext context) {
    var profilePicture = Constants.user?.image;
    var email = Constants.user?.email;

    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      centerTitle: false,
      title: scanner
          ? _scannerIcon(context)
          : profilePicture != null
              ? CustomCircleAvathar(url: profilePicture, radius: 20)
              : CircleAvatar(
                  child: Text(email?[0].toUpperCase() ?? ''),
                ),
      actions: [_searchIcon(context), Gap.width(20)],
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, bottom == null ? 0 : 50),
        child: bottom ?? Constants.none,
      ),
      floating: true,
      snap: true,
      elevation: 0,
    );
  }

  SquareIconButton _searchIcon(BuildContext context) {
    return SquareIconButton(
      icon: Icons.search,
      onTap: () => Navigator.of(context).pushNamed('/search'),
    );
  }

  SquareIconButton _scannerIcon(BuildContext context) {
    return SquareIconButton(
      icon: Icons.qr_code_scanner_rounded,
      onTap: () {
        if (kIsWeb) {
          // _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
          //     context: context,
          //     onCode: (code) {
          //       if (code != null) {
          //         if (!code.contains('Fork and Fusion')) {
          //           showCustomSnackbar(
          //               context: context,
          //               message:
          //                   'Looks like you scanned a QR code that doesn’t belong to our restaurant. Please scan the QR code at your table to view the menu',
          //               isSuccess: false);
          //         }
          //         Constants.table = code.split('_').sublist(1, 3).join(' ');
          //         log(Constants.table);
          //         context.read<ProductBloc>().add(FeatchAllProducts());
          //       }
          //     });
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
      },
    );
  }
}
