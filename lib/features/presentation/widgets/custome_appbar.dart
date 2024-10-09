// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/bloc/product/product_bloc.dart';
import 'package:fork_and_fusion/features/presentation/widgets/snackbar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/buttons/square_icon_button.dart';

class CustomAppbar extends StatelessWidget {
  Widget? bottom;
  bool scanner;
  CustomAppbar({super.key, this.bottom, this.scanner = false});

  @override
  Widget build(BuildContext context) {
    var profilePicture = Constants.user?.image;
    var email = Constants.user?.email;

    return SliverAppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      title: scanner
          ? SquareIconButton(
              icon: Icons.qr_code_scanner_rounded,
              onTap: () {
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
              },
            )
          : profilePicture != null
              ? CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(profilePicture),
                )
              : CircleAvatar(
                  child: Text(email?[0].toUpperCase() ?? ''),
                ),
      actions: [
        SquareIconButton(
          icon: Icons.search,
          onTap: () {
            Navigator.of(context).pushNamed('/search');
          },
        ),
        const SizedBox(
          width: 20,
        )
      ],
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, bottom == null ? 0 : 50),
        child: bottom ?? Constants.none,
      ),
      floating: true,
      snap: true,
      elevation: 0,
    );
  }
}
