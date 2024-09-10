import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/widgets/square_icon_button.dart';

customAppbar(BuildContext context, {Widget? bottom, bool scanner = false}) {
  return SliverAppBar(
   backgroundColor: Colors.white,
    centerTitle: false,
    title: scanner
        ? SquareIconButton(
            icon: Icons.qr_code_scanner_rounded,
            onTap: () async {
              var scannedData =
                  await Navigator.of(context).pushNamed('/qrscanner');
            },
          )
        : const CircleAvatar(),
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
